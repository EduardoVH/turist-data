import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:turist_data/core/router/app_router.dart';
import '../blocs/register_bloc.dart';
import '../blocs/register_event.dart';
import '../blocs/register_state.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({super.key});

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  void _onRegisterPressed() {
    final email = _emailController.text.trim();
    final password = _passwordController.text;
    final confirm = _confirmPasswordController.text;

    if (password != confirm) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Las contraseñas no coinciden')),
      );
      return;
    }

    context.read<RegisterBloc>().add(
          RegisterRequested(email: email, password: password),
        );

    setState(() => _isLoading = true);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterBloc, RegisterState>(
      builder: (context, state) {
        if (state is RegisterLoading && !_isLoading) _isLoading = true;
        if (state is! RegisterLoading && _isLoading) _isLoading = false;

        return Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFE8F5E9), Color(0xFFE8F5E9)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
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
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Align(
                        alignment: Alignment.topRight,
                        child: IconButton(
                          icon: const Icon(Icons.close, size: 28),
                          onPressed: () => context.pop(),
                        ),
                      ),
                      const SizedBox(height: 40),
                      const CircleAvatar(
                        radius: 36,
                        backgroundColor: Colors.grey,
                        child: Icon(Icons.person_add, size: 36, color: Colors.white),
                      ),
                      const SizedBox(height: 16),
                      const Text(
                        'Crear Cuenta',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 32),
                      _InputField(
                        controller: _emailController,
                        label: 'Correo electrónico',
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        controller: _passwordController,
                        label: 'Contraseña',
                        obscure: true,
                      ),
                      const SizedBox(height: 16),
                      _InputField(
                        controller: _confirmPasswordController,
                        label: 'Confirmar contraseña',
                        obscure: true,
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: _isLoading ? null : _onRegisterPressed,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00CDBE),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                    strokeWidth: 2, color: Colors.white),
                              )
                            : const Text('Registrarse', style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: GestureDetector(
                           onTap: () => context.go(RouterConstants.login),
                          child: const Text.rich(
                            TextSpan(
                              text: '¿Ya tienes cuenta? ',
                              children: [
                                TextSpan(
                                  text: 'Iniciar sesión',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                ],
                            ),
                          ),
                        ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final bool obscure;
  final TextEditingController controller;

  const _InputField({
    required this.label,
    this.obscure = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: label,
        filled: true,
        fillColor: Colors.white.withOpacity(0.7),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
