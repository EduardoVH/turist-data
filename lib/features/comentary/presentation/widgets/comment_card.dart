import 'package:flutter/material.dart';

class CommentCard extends StatelessWidget {
  final String nombre;
  final String ciudad;
  final String comentario;
  final String fecha;
  final double rating;

  const CommentCard({
    super.key,
    required this.nombre,
    required this.ciudad,
    required this.comentario,
    required this.fecha,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundImage: NetworkImage('https://i.pravatar.cc/150'),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(nombre, style: const TextStyle(fontWeight: FontWeight.bold)),
                  Text(ciudad, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
              const Spacer(),
              Text(fecha, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.star, color: Colors.orangeAccent, size: 18),
              const SizedBox(width: 4),
              Text(rating.toString()),
            ],
          ),
          const SizedBox(height: 6),
          Text(comentario, style: const TextStyle(fontSize: 14, height: 1.5)),
        ],
      ),
    );
  }
}
