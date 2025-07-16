import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DestinationDetailPage extends StatelessWidget {
  final Map<String, String> data;

  const DestinationDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F9F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Column(
        children: [
          Hero(
            tag: data['place']!,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
              child: Image.network(
                data['image'] ?? '',
                height: 280,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.broken_image, size: 100),
              ),
            ),
          ),
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Color(0xFFF0F9F3),
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, -4),
                  ),
                ],
              ),
              child: Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data['place'] ?? '',
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        data['category'] ?? '',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.teal,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        data['subtitle'] ?? 'No hay descripción disponible.',
                        style: const TextStyle(
                          fontSize: 16,
                          height: 1.5,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                title: const Center(
                                  child: Text(
                                    'Ver más detalles',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                                content: const Text(
                                  'Para ver más detalles, por favor regístrate o inicia sesión.\n\n¿Quieres registrarte ahora?',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 16),
                                ),
                                actionsAlignment: MainAxisAlignment.center,
                                actionsPadding:
                                const EdgeInsets.only(bottom: 12),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: const Text(
                                      'Cancelar',
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                      context.go('/register');
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.teal,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 10),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Aceptar',
                                      style: TextStyle(
                                          fontSize: 16, color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          icon: const Icon(Icons.explore),
                          label: const Text('Explorar más'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.teal,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 14),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
