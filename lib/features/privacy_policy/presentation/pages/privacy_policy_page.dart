import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({super.key});

  @override
  State<PrivacyPolicyPage> createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  String? userEmail;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _checkAcceptanceAndLoadEmail();
  }

  Future<void> _checkAcceptanceAndLoadEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('userEmail');

    if (email == null || email.isEmpty) {
      // No email encontrado, quizá no deberías permitir continuar
      setState(() {
        userEmail = null;
        _loading = false;
      });
      return;
    }

    final accepted = prefs.getBool('privacyAccepted_$email') ?? false;

    if (accepted) {
      // Ya aceptó, navegar a home
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.go('/home');
      });
    } else {
      setState(() {
        userEmail = email;
        _loading = false;
      });
    }
  }

  Future<void> _acceptPrivacyPolicy() async {
    if (userEmail == null) return; // Seguridad

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('privacyAccepted_$userEmail', true);

    context.go('/home');
  }

  static const String policyText = '''
De conformidad con la Ley Federal de Protección de Datos Personales en Posesión de los Particulares, informamos:

¿QUIÉNES SOMOS?
Empresa dedicada a servicios de información turística  Avenida Primera Poniente Sur, núm. 228, col. Santa Anita, Centro, C.P. 29150, Suchiapa, Chiapas

¿QUÉ DATOS OBTENEMOS?
• Nombre de usuario
• Correo electrónico
• Contraseña (cifrada)
• Ubicación geográfica

NO solicitamos: Datos bancarios, números de tarjeta, teléfonos o fotografías

¿PARA QUÉ USAMOS SUS DATOS?
• Uso principal: Crear su cuenta y brindar servicios turísticos
• Uso secundario: Mejorar la app y enviar recomendaciones personalizadas

SUS DERECHOS (ARCO)
Puede Acceder, Rectificar, Cancelar u Oponerse al uso de sus datos.

¿CÓMO EJERCER SUS DERECHOS?
Contacto: turistdata@ejemplo.com
Respuesta: Máximo 20 días hábiles

SEGURIDAD
Sus datos están protegidos con medidas de seguridad técnicas y administrativas.
''';

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (userEmail == null) {
      return Scaffold(
        body: Center(
          child: Text(
            'No se encontró usuario para mostrar las políticas.\nPor favor inicia sesión nuevamente.',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF0F9F3),
      body: Stack(
        children: [
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
                children: [
                  const SizedBox(height: 24),
                  const Text(
                    'Políticas De Privacidad',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 0.5,
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
                    userEmail!,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'TURISTDATA',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      letterSpacing: 1,
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Expanded(
                    child: Scrollbar(
                      thumbVisibility: true,
                      child: SingleChildScrollView(
                        child: Text(
                          policyText,
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                            backgroundColor: Colors.transparent,
                            letterSpacing: 0.5,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: _acceptPrivacyPolicy,
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
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
