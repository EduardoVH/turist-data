import 'package:flutter/material.dart';
import 'rating_box.dart'; // Importa sólo desde aquí RatingBox

class CommentCard extends StatelessWidget {
  final String usuario;
  final String comentario;

  const CommentCard({
    super.key,
    required this.usuario,
    required this.comentario,
    //required this.limpieza,
    //required this.atencion,
    //required this.comodidad,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(usuario,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16)),
            const SizedBox(height: 8),
            Text(comentario),
            const SizedBox(height: 12),

          ],
        ),
      ),
    );
  }
}
