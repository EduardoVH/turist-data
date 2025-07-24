import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:turist_data/core/session/usuario_session.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final String userName = UsuarioSession.nombre.isNotEmpty ? UsuarioSession.nombre : 'Usuario';
    final String userEmail = UsuarioSession.correo.isNotEmpty ? UsuarioSession.correo : 'Sin correo';

    const String policyText = '''
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

    return Stack(
      children: [
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
                  userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  userEmail,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
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
                        onPressed: () => context.go('/home'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(vertical: 14),
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
                          padding: EdgeInsets.symmetric(vertical: 14),
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
    );
  }
}
