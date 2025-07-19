import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart'; // para volver con context.pop

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({super.key});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _controller = TextEditingController();
  final List<_Message> _messages = [
    _Message(
      text: '¡Estoy aquí para ayudarte sobre turismo en México! 😊',
      isBot: true,
    ),
  ];

  late final GenerativeModel _model;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _model = GenerativeModel(
      model: 'gemini-1.5-flash',
      apiKey: dotenv.env['API_KEY_CHAT'] ?? '',
    );
  }

  /// Enviar mensaje
  void _sendMessage() async {
    final userMessage = _controller.text.trim();
    if (userMessage.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(_Message(text: userMessage, isBot: false));
      _controller.clear();
      _isLoading = true;
    });

    final botResponse = await _fetchBotResponse(userMessage);

    setState(() {
      _messages.add(_Message(text: botResponse, isBot: true));
      _isLoading = false;
    });
  }

  /// Obtener respuesta del modelo
  Future<String> _fetchBotResponse(String userMessage) async {
    try {
      final prompt = '''
      Eres un asistente experto en turismo en México.
      Solo responde preguntas relacionadas con lugares turísticos, cultura, gastronomía o tradiciones de México.
      Si te preguntan algo que no sea sobre México, responde:
      "Solo puedo dar información sobre turismo en México."
      
      Pregunta del usuario: $userMessage
      ''';

      final response = await _model.generateContent([Content.text(prompt)]);

      if (response.text != null) {
        return response.text!.trim();
      } else {
        return 'Lo siento, no encontré información.';
      }
    } catch (e) {
      return 'Error al contactar la IA: $e';
    }
  }

  /// Limpiar el chat
  void _clearChat() {
    setState(() {
      _messages.clear();
      _messages.add(const _Message(
        text: '¡Estoy aquí para ayudarte sobre turismo en México! 😊',
        isBot: true,
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Asistente'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Vuelve al Home usando GoRouter
            context.go('/'); // O RouterConstants.home si lo prefieres
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_outline),
            tooltip: 'Limpiar chat',
            onPressed: _clearChat,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return Align(
                  alignment:
                      msg.isBot ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: msg.isBot
                          ? const Color(0xFFE0F2F1)
                          : const Color(0xFF00CDBE),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      msg.text,
                      style: TextStyle(
                        color: msg.isBot ? Colors.black87 : Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration.collapsed(
                        hintText: 'Escribe tu mensaje...'),
                    onSubmitted: (_) => _sendMessage(),
                  ),
                ),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send,
                      color:
                          _isLoading ? Colors.grey : const Color(0xFF00CDBE)),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _Message {
  final String text;
  final bool isBot;
  const _Message({required this.text, required this.isBot});
}
