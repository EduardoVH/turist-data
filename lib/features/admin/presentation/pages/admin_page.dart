import 'package:flutter/material.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Administrador'),
      ),
      body: const Center(
        child: Text(
          'Bienvenido, administrador',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
