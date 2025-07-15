import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  final String userName = 'Alfredo Garcia';
  final String userEmail = 'AlfredoGarcia@example.com';
  final String policyText =
      'En TuristData, nos comprometemos a proteger tu privacidad y mantener segura la información que nos confías. Esta Política de Privacidad describe qué datos recopilamos, cómo los usamos y tus derechos sobre ellos.\n\nAl utilizar nuestra aplicación, aceptas esta política. Si no estás de acuerdo con alguno de sus términos, por favor no uses la App.';

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Fondo blanco
        Container(color: const Color(0xFFF0F9F3)),


        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.network(
            'https://i.imgur.com/VqkZhz5.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const SizedBox(),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Image.network(
            'https://i.imgur.com/hFeYeGN.png',
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => const SizedBox(),
          ),
        ),


        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Políticas De Privacidad',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 24),
                const CircleAvatar(
                  radius: 40,
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                const SizedBox(height: 12),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black, // ✅ negro
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
                const SizedBox(height: 24),
                Text(
                  policyText,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black87,
                    backgroundColor: Colors.transparent,
                  ),
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 36),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => context.go('/home'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: const Text('Aceptar'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => context.go('/'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Colors.teal),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          foregroundColor: Colors.teal,
                        ),
                        child: const Text('Rechazar'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
