import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  final List<Map<String, String>> events = const [
    {
      'season': 'Verano',
      'title': 'Festival de Música en la Playa',
      'description':
          'Disfruta de conciertos en vivo. DJs y actividades acuáticas en las playas de Cancún.',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e'
    },
    {
      'season': 'Otoño',
      'title': 'Día de Muertos en Oaxaca',
      'description':
          'Celebra esta tradición ancestral con altares, desfiles y gastronomía típica en las calles de Oaxaca.',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e'
    },
    {
      'season': 'Invierno',
      'title': 'Festival de Luces en San Miguel de Allende',
      'description':
          'Admira las calles iluminadas, espectáculos de luces y eventos culturales en esta ciudad colonial.',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e'
    },
    {
      'season': 'Primavera',
      'title': 'Equinoccio de Chichén Itzá',
      'description':
          'Presencia el fenómeno de luz y sombra en la pirámide de Kukulkán durante el equinoccio de primavera.',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F9F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Eventos Especiales',
            style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            context.pop(); // 🠔 Regresa a la vista anterior
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            const Text('Eventos de Temporada',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: events.length,
                itemBuilder: (context, index) {
                  final event = events[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: EventCard(data: event),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2, // Posición del ítem "Eventos"
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: (index) {
          final routes = [
            '/home',
            '/explore',
            '/eventos', // Actual
            '/chat',
            '/profile',
          ];
          context.go(routes[index]);
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorar'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Eventos'),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          BottomNavigationBarItem(
              icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Map<String, String> data;
  const EventCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          data['season'] ?? '',
          style: const TextStyle(
              fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
        ),
        const SizedBox(height: 8),
        AspectRatio(
          aspectRatio: 2.5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              data['image'] ?? '',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) =>
                  const Center(child: Icon(Icons.broken_image)),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          data['title'] ?? '',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 4),
        Text(
          data['description'] ?? '',
          style: const TextStyle(color: Colors.grey),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: () {
              // Aquí puedes redirigir a más detalles
            },
            child: const Text('Ver detalles'),
          ),
        ),
      ],
    );
  }
}
