import 'dart:math';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

class _CommentPageState extends State<CommentPage> {
  final TextEditingController _commentController = TextEditingController();

  List<Comment> _comments = [];
  double _selectedRating = 0; // Para la calificación del usuario

  @override
  void initState() {
    super.initState();
    fetchComments();
  }

  // Obtener comentarios desde el backend
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

  // Enviar nuevo comentario al backend
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
        Uri.parse('https://turistdata-back.onrender.com/api/comentarios/comentario'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'comentario': text,
          'rating': _selectedRating,
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        _commentController.clear();
        setState(() {
          _selectedRating = 0; // Resetear rating después de enviar
        });
        await fetchComments(); // Recargar comentarios para mostrar el nuevo
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
          final routes = [
            '/home',
            '/explore',
            '/chat',
            '/profile',
          ];
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
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          // Imagen destacada
          ClipRRect(
            child: Image.network(
              'https://i.postimg.cc/KzdTGpk0/Rectangle-45.png',
              height: 200,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          const SizedBox(height: 16),

          // Sección de calificaciones
          const Text('Calificaciones generales',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
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
              Text('4.83 promedio de 52 evaluaciones',
                  style: TextStyle(fontSize: 14)),
            ],
          ),

          const SizedBox(height: 16),

          // Lista de comentarios dinámicos
          if (_comments.isEmpty)
            const Center(child: Text('No hay comentarios que mostrar.')),
          ..._comments.map((c) => CommentCard(
            nombre: c.nombre,
            ciudad: c.ciudad,
            comentario: c.comentario,
            fecha: c.fecha,
            rating: c.rating,
          )),

          const SizedBox(height: 20),

          // Campo para escribir nuevo comentario
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

          // Selector de estrellas para calificación
          buildStarRating(),

          const SizedBox(height: 8),

          // Emoji que cambia según la calificación
          Center(child: _buildEmoji()),

          const SizedBox(height: 12),

          // Botón enviar
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
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

// Widgets y clases auxiliares abajo (sin cambios)

class StarWithSparkles extends StatefulWidget {
  final bool isSelected;
  final VoidCallback onTap;
  final IconData icon;
  final Color color;
  final double size;

  const StarWithSparkles({
    Key? key,
    required this.isSelected,
    required this.onTap,
    required this.icon,
    required this.color,
    required this.size,
  }) : super(key: key);

  @override
  State<StarWithSparkles> createState() => _StarWithSparklesState();
}

class _StarWithSparklesState extends State<StarWithSparkles>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  bool _showSparkles = false;

  final int numSparkles = 8;
  final double sparkleRadius = 20;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          _showSparkles = false;
        });
        _controller.reset();
      }
    });
  }

  @override
  void didUpdateWidget(covariant StarWithSparkles oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Cuando la selección cambia a true, disparar la animación y sparkles
    if (widget.isSelected && !oldWidget.isSelected) {
      setState(() {
        _showSparkles = true;
      });
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<Widget> _buildSparkles() {
    final List<Widget> sparkles = [];
    final random = Random();

    for (int i = 0; i < numSparkles; i++) {
      final angle = (2 * pi / numSparkles) * i;
      final distance = sparkleRadius * (0.7 + random.nextDouble() * 0.6);
      final delay = i * 50; // ms

      sparkles.add(_SparkleParticle(
        angle: angle,
        distance: distance,
        delay: Duration(milliseconds: delay),
        controller: _controller,
      ));
    }

    return sparkles;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        width: widget.size * 2,
        height: widget.size * 2,
        child: Stack(
          alignment: Alignment.center,
          children: [
            ScaleTransition(
              scale: _scaleAnimation,
              child: Icon(
                widget.icon,
                color: widget.color,
                size: widget.size,
              ),
            ),
            if (_showSparkles) ..._buildSparkles(),
          ],
        ),
      ),
    );
  }
}

class _SparkleParticle extends StatelessWidget {
  final double angle;
  final double distance;
  final Duration delay;
  final AnimationController controller;

  const _SparkleParticle({
    Key? key,
    required this.angle,
    required this.distance,
    required this.delay,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Animation<double> moveOut = Tween<double>(begin: 0, end: distance)
        .animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          delay.inMilliseconds / 600,
          1.0,
          curve: Curves.easeOut,
        ),
      ),
    );

    final Animation<double> fadeOut = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: controller,
        curve: Interval(
          delay.inMilliseconds / 600,
          1.0,
          curve: Curves.easeIn,
        ),
      ),
    );

    return AnimatedBuilder(
      animation: controller,
      builder: (context, child) {
        final dx = moveOut.value * cos(angle);
        final dy = moveOut.value * sin(angle);

        return Positioned(
          left: 24 + dx,
          top: 24 + dy,
          child: Opacity(
            opacity: fadeOut.value,
            child: child,
          ),
        );
      },
      child: Container(
        width: 6,
        height: 6,
        decoration: BoxDecoration(
          color: Colors.orangeAccent,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.orangeAccent.withOpacity(0.7),
              blurRadius: 4,
              spreadRadius: 1,
            )
          ],
        ),
      ),
    );
  }
}

class RatingBox extends StatelessWidget {
  final String label;
  final double rating;

  const RatingBox({
    super.key,
    required this.label,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.95),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.orangeAccent, size: 18),
                const SizedBox(width: 4),
                Text(rating.toString(), style: const TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

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

class Comment {
  final String nombre;
  final String ciudad;
  final String comentario;
  final String fecha;
  final double rating;

  Comment({
    required this.nombre,
    required this.ciudad,
    required this.comentario,
    required this.fecha,
    required this.rating,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      nombre: json['nombre'] ?? 'Anónimo',
      ciudad: json['ciudad'] ?? 'Desconocida',
      comentario: json['comentario'] ?? '',
      fecha: json['fecha'] ?? '',
      rating: (json['rating'] != null) ? double.tryParse(json['rating'].toString()) ?? 0 : 0,
    );
  }
}
