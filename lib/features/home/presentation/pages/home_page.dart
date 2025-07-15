import 'package:aplicacion2/core/router/app_router.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color lightGreen = const Color(0xFFE6F2E6);

  int _selectedIndex = 0;

  final List<String> _routes = [
    RouterConstants.home,
    RouterConstants.explore,
    RouterConstants.chat,
    RouterConstants.profile,
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: lightGreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorar'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      'https://images.unsplash.com/photo-1507525428034-b723cf961d3e',
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    left: 15,
                    child: const Text(
                      'Nuevo evento en\nCancún 🎉',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        shadows: [Shadow(blurRadius: 5, color: Colors.black)],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    right: 15,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {
                        context.go(RouterConstants.explore);
                      },
                      child: const Text('Ver'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'Bienvenido, Alex!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              const Text(
                'Descubra los mejores lugares de comida de\nMéxico',
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 20),
              const Text(
                'Acceso rápido',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const QuickAccessCard(
                title: 'Destinos Populares',
                subtitle: 'Descubre lugares fantásticos',
                imageUrl: 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90',
              ),
              const QuickAccessCard(
                title: 'Eventos especiales',
                subtitle: 'Exclusive dining experiences.',
                imageUrl: 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092',
              ),
              const QuickAccessCard(
                title: 'Sugerencias del sistema',
                subtitle: 'Opciones gastronómicas personalizadas.',
                imageUrl: 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092',
              ),
              const QuickAccessCard(
                title: 'Chat',
                subtitle: 'Obtenga asistencia en cualquier momento.',
                imageUrl: 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class QuickAccessCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String imageUrl;

  const QuickAccessCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: Color.fromRGBO(255, 255, 255, 0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.network(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        onTap: () {},
      ),
    );
  }
}
