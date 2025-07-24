import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({super.key});

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
          context.go(routes[index]);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorar'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
      body: ListView(
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Filtro y buscador
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
                  child: const Text('Lo más relevante'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Buscar reseñas',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: const EdgeInsets.symmetric(vertical: 0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Lista de comentarios
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                CommentCard(
                  nombre: 'Carlos López',
                  ciudad: 'Oaxaca',
                  comentario: 'Excelente ambiente y comida deliciosa. Recomendado!',
                  fecha: '12 Jul 2025',
                  rating: 4.8,
                ),
                CommentCard(
                  nombre: 'Mónica García',
                  ciudad: 'San Cristóbal',
                  comentario: 'Me encantó la música en vivo y la atención del personal.',
                  fecha: '10 Jul 2025',
                  rating: 5.0,
                ),
                CommentCard(
                  nombre: 'Luis Hernández',
                  ciudad: 'Palenque',
                  comentario: 'Buen lugar para pasar la tarde con amigos.',
                  fecha: '08 Jul 2025',
                  rating: 4.5,
                ),
                CommentCard(
                  nombre: 'Andrea Pérez',
                  ciudad: 'Tuxtla Gutiérrez',
                  comentario:
                  'Las bebidas estaban increíbles y el lugar súper acogedor.',
                  fecha: '05 Jul 2025',
                  rating: 4.9,
                ),
              ],
            ),
          ),
        ],
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
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 4)],
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
