import 'package:flutter/material.dart';

class EventDetailPage extends StatelessWidget {
  final Map<String, dynamic> data;
  const EventDetailPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(data['nombre'] ?? 'Evento')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Descripción: ${data['descripcion'] ?? 'Sin descripción'}'),
            const SizedBox(height: 8),
            Text('Estado afectado: ${data['estado_afectado'] ?? 'Desconocido'}'),
            Text('Inicio: ${data['fecha_inicio'] ?? ''}'),
            Text('Fin: ${data['fecha_final'] ?? ''}'),
          ],
        ),
      ),
    );
  }
}
