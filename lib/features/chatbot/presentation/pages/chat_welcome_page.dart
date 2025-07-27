import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatWelcomePage extends StatefulWidget {
  final List<String> sugerencias;
  final void Function(String)? onSeleccion;

  const ChatWelcomePage({
    super.key,
    required this.sugerencias,
    this.onSeleccion,
  });

  @override
  State<ChatWelcomePage> createState() => _ChatWelcomePageState();
}

class _ChatWelcomePageState extends State<ChatWelcomePage> {
  String? _opcionSeleccionada;

  void _irAlChat({String? pregunta}) {
    final ruta = pregunta == null
        ? '/chat'
        : '/chat?pregunta=${Uri.encodeComponent(pregunta)}';
    context.go(ruta);
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Texto de bienvenida
                const Padding(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    'Hola 👋 ¿En qué puedo ayudarte hoy?',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                      height: 1.3,
                    ),
                  ),
                ),

                // Opciones seleccionables con scroll si son muchas
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      spacing: 12,
                      runSpacing: 12,
                      children: widget.sugerencias.map((opcion) {
                        final seleccionada = _opcionSeleccionada == opcion;
                        return ChoiceChip(
                          label: Text(
                            opcion,
                            style: TextStyle(
                              color: seleccionada ? Colors.white : Colors.black87,
                              fontSize: 16,
                            ),
                          ),
                          selected: seleccionada,
                          selectedColor: Colors.teal.shade400,
                          backgroundColor: Colors.grey.shade200,
                          onSelected: (_) {
                            setState(() {
                              _opcionSeleccionada = opcion;
                            });
                            _irAlChat(pregunta: opcion); // Navega directo al chat
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ),

                // Botón iniciar chat fijo abajo
                Padding(
                  padding: const EdgeInsets.only(top: 24, bottom: 12),
                  child: Center(
                    child: ElevatedButton.icon(
                      onPressed: () => _irAlChat(),
                      icon: const Icon(Icons.chat_bubble_outline),
                      label: const Text('Iniciar chat'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF00CDBE),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        textStyle: const TextStyle(fontSize: 18),
                        elevation: 5,
                        shadowColor: Colors.teal.shade200,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
