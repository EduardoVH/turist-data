import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../data/models/comments_models.dart';
import '../widgets/comment_card.dart';
import '../widgets/rating_box.dart';
import '../widgets/star_with_sparkles.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _commentController = TextEditingController();

  List<Comment> _comments = [];
  double _selectedRating = 0;

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  Future<void> fetchComments() async {
    try {
      final response = await http.get(
        Uri.parse('https://turistdata-back.onrender.com/api/comentarios/comentario'),
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final comments = data.map((json) => Comment.fromJson(json)).toList();
        setState(() {
          _comments = comments;
        });
      } else {
        debugPrint('Error al obtener comentarios: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error fetchComments: $e');
    }
  }

  Future<void> sendComment() async {
    final text = _commentController.text.trim();
    if (text.isEmpty || _selectedRating == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor escribe un comentario y selecciona una calificación')),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('https://turistdata-back.onrender.com/api/comentarios/comentario/rg'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'comentario': text,
          'rating': _selectedRating,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _commentController.clear();
        setState(() {
          _selectedRating = 0;
        });
        await fetchComments();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al enviar comentario: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Error de conexión al enviar comentario')),
      );
    }
  }

  Widget buildStarRating() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final starIndex = index + 1;
        return StarWithSparkles(
          isSelected: _selectedRating == starIndex,
          icon: starIndex <= _selectedRating ? Icons.star : Icons.star_border,
          color: Colors.orangeAccent,
          size: 32,
          onTap: () {
            setState(() {
              _selectedRating = starIndex.toDouble();
            });
          },
        );
      }),
    );
  }

  Widget _buildEmoji() {
    String emoji = '';
    switch (_selectedRating.toInt()) {
      case 5:
        emoji = '😎';
        break;
      case 3:
        emoji = '😐';
        break;
      case 2:
        emoji = '😢';
        break;
      case 1:
        emoji = '😱';
        break;
      default:
        if (_selectedRating > 0) {
          emoji = '🙂';
        }
    }

    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 400),
      transitionBuilder: (child, animation) => ScaleTransition(scale: animation, child: child),
      child: emoji.isNotEmpty
          ? Text(
        emoji,
        key: ValueKey<String>(emoji),
        style: const TextStyle(fontSize: 48),
        textAlign: TextAlign.center,
      )
          : const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F9F3),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          final routes = ['/home', '/explore', '/chat', '/profile'];
          if (index >= 0 && index < routes.length) {
            GoRouter.of(context).go(routes[index]);
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorar'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 22),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                'https://i.postimg.cc/KzdTGpk0/Rectangle-45.png',
                height: MediaQuery.of(context).size.height * 0.25,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),

          const SizedBox(height: 16),
          const Text(
            'Calificaciones generales',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              RatingBox(label: 'Limpieza', rating: 4.8),
              SizedBox(width: 12),
              RatingBox(label: 'Atención', rating: 4.8),
              SizedBox(width: 12),
              RatingBox(label: 'Comodidad', rating: 4.8),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: const [
              Icon(Icons.star, color: Colors.orangeAccent),
              SizedBox(width: 6),
              Text(
                '4.83 promedio de 52 evaluaciones',
                style: TextStyle(fontSize: 14),
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_comments.isEmpty)
            const Center(child: Text('No hay comentarios que mostrar.')),

          ..._comments.map(
                (c) => CommentCard(
              nombre: c.nombre,
              ciudad: c.ciudad,
              comentario: c.comentario,
              fecha: c.fecha,
              rating: c.rating,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _commentController,
            decoration: InputDecoration(
              hintText: 'Escribe tu comentario...',
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              contentPadding:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            ),
            maxLines: 2,
          ),
          const SizedBox(height: 12),
          buildStarRating(),
          const SizedBox(height: 8),
          Center(child: _buildEmoji()),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: sendComment,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text('Publicar'),
              ),
            ],
          ),

          const SizedBox(height: 24),

        ],
      ),
    );
  }
}
