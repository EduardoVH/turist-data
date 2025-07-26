import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../data/models/comments_models.dart';


class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _comentarioController = TextEditingController();
  double _rating = 0.0;
  List<Comment> _comentarios = [];

  @override
  void initState() {
    super.initState();
    _cargarComentarios();
  }

  Future<void> _cargarComentarios() async {
    final url = Uri.parse('https://turistdata-back.onrender.com/api/comentarios/comentario');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _comentarios = data.map((json) => Comment.fromJson(json)).toList();
        });
      } else {
        debugPrint('Error al cargar comentarios: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error de red al cargar comentarios: $e');
    }
  }

  Future<void> _enviarComentario() async {
    final url = Uri.parse('https://turistdata-back.onrender.com/api/comentarios/comentario/rg');

    final nuevoComentario = {
      'nombre': 'Usuario Prueba',
      'ciudad': 'Ciudad Demo',
      'comentario': _comentarioController.text,
      'fecha': DateTime.now().toIso8601String(),
      'rating': _rating.toStringAsFixed(1),
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(nuevoComentario),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _comentarioController.clear();
        _rating = 0.0;
        await _cargarComentarios();
      } else {
        debugPrint('Error al enviar comentario: ${response.statusCode}');
        debugPrint('Cuerpo: ${response.body}');
      }
    } catch (e) {
      debugPrint('Error de red al enviar comentario: $e');
    }
  }

  Widget _buildEmojiForRating(double rating) {
    if (rating >= 4.5) {
      return const Text('😎', style: TextStyle(fontSize: 28));
    } else if (rating >= 3) {
      return const Text('🙂', style: TextStyle(fontSize: 28));
    } else {
      return const Text('😬', style: TextStyle(fontSize: 28));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Comentarios")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            RatingBar.builder(
              initialRating: _rating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemBuilder: (context, index) => Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 32),
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 300),
                    top: -8,
                    child: _rating > index ? _buildSparkleEffect() : const SizedBox(),
                  ),
                ],
              ),
              onRatingUpdate: (rating) {
                setState(() => _rating = rating);
              },
            ),
            const SizedBox(height: 10),
            _buildEmojiForRating(_rating),
            const SizedBox(height: 10),
            TextField(
              controller: _comentarioController,
              decoration: const InputDecoration(labelText: 'Escribe tu comentario'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _enviarComentario,
              child: const Text("Enviar comentario"),
            ),
            const Divider(height: 30),
            const Text("Comentarios recientes:", style: TextStyle(fontSize: 18)),
            const SizedBox(height: 10),
            Expanded(
              child: ListView.builder(
                itemCount: _comentarios.length,
                itemBuilder: (context, index) {
                  final comentario = _comentarios[index];
                  return Card(
                    child: ListTile(
                      title: Text(comentario.nombre),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(comentario.comentario),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              Icon(Icons.star, color: Colors.amber, size: 16),
                              const SizedBox(width: 4),
                              Text(comentario.rating.toString()),
                            ],
                          ),
                        ],
                      ),
                      trailing: Text(
                        comentario.fecha.split('T')[0],
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSparkleEffect() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        3,
            (index) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1),
          child: AnimatedOpacity(
            opacity: 1,
            duration: Duration(milliseconds: 200 + index * 100),
            child: const Icon(Icons.star, color: Colors.white70, size: 8),
          ),
        ),
      ),
    );
  }
}
