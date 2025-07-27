<<<<<<< HEAD
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

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
            context.go('/'); 
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
=======
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:go_router/go_router.dart';

class ChatBotPage extends StatefulWidget {
  final String? preguntaInicial;
  const ChatBotPage({super.key, this.preguntaInicial});

  @override
  State<ChatBotPage> createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> with TickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  final List<_Message> _messages = [
    const _Message(
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

    if (widget.preguntaInicial != null && widget.preguntaInicial!.trim().isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _enviarPreguntaInicial(widget.preguntaInicial!.trim());
      });
    }
  }

  Future<void> _enviarPreguntaInicial(String pregunta) async {
    setState(() {
      _messages.add(_Message(text: pregunta, isBot: false));
      _isLoading = true;
    });
    _scrollToBottom();

    final respuesta = await _fetchBotResponse(pregunta);

    setState(() {
      _messages.add(_Message(text: respuesta, isBot: true));
      _isLoading = false;
    });
    _scrollToBottom();
  }

  Future<void> _sendMessage() async {
    final userMessage = _controller.text.trim();
    if (userMessage.isEmpty || _isLoading) return;

    setState(() {
      _messages.add(_Message(text: userMessage, isBot: false));
      _controller.clear();
      _isLoading = true;
    });
    _scrollToBottom();

    final botResponse = await _fetchBotResponse(userMessage);

    setState(() {
      _messages.add(_Message(text: botResponse, isBot: true));
      _isLoading = false;
    });
    _scrollToBottom();
  }

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
      return response.text?.trim() ?? 'Lo siento, no encontré información.';
    } catch (e) {
      return 'Error al contactar la IA: $e';
    }
  }

  void _clearChat() {
    setState(() {
      _messages.clear();
      _messages.add(const _Message(
        text: '¡Estoy aquí para ayudarte sobre turismo en México! 😊',
        isBot: true,
      ));
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent + 80,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Widget _buildMessageBubble(_Message msg) {
    final isBot = msg.isBot;
    final alignment = isBot ? Alignment.centerLeft : Alignment.centerRight;
    final color = isBot ? Colors.white : const Color(0xFF00CDBE);
    final textColor = isBot ? Colors.black87 : Colors.white;
    final radius = isBot
        ? const BorderRadius.only(
      topLeft: Radius.circular(0),
      topRight: Radius.circular(16),
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    )
        : const BorderRadius.only(
      topLeft: Radius.circular(16),
      topRight: Radius.circular(0),
      bottomLeft: Radius.circular(16),
      bottomRight: Radius.circular(16),
    );

    return Align(
      alignment: alignment,
      child: Container(
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.75),
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: color,
          borderRadius: radius,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.08),
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Text(
          msg.text,
          style: TextStyle(fontSize: 16, color: textColor, height: 1.3),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFAFAF5), Color(0xFFDFF5E1)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.teal),
                      onPressed: () => context.go('/home'),
                    ),
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Asistente',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.teal,
                            shadows: [Shadow(color: Colors.black12, offset: Offset(1, 1), blurRadius: 2)],
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.teal),
                      tooltip: 'Limpiar chat',
                      onPressed: _clearChat,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) => _buildMessageBubble(_messages[index]),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10, offset: const Offset(0, -1))],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _controller,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Escribe tu mensaje...',
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none),
                          filled: true,
                          fillColor: const Color(0xFFF0F9F3),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        ),
                        onSubmitted: (_) => _sendMessage(),
                        enabled: !_isLoading,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: _isLoading ? null : _sendMessage,
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _isLoading ? Colors.grey : const Color(0xFF00CDBE),
                          shape: BoxShape.circle,
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 6, offset: const Offset(0, 2))],
                        ),
                        child: _isLoading
                            ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                          ),
                        )
                            : const Icon(Icons.send, color: Colors.white, size: 24),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Message {
  final String text;
  final bool isBot;

  const _Message({required this.text, required this.isBot});
}
>>>>>>> 2a8a2670ed3cd7a96ed935c3658cab3e8347b3a2
