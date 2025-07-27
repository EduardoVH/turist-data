import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:turist_data/core/router/app_router.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final Color lightGreen = const Color(0xFFF0F9F3);
  int _selectedIndex = 0;

  String userEmail = '';

  final List<String> _routes = [
    RouterConstants.home,
    RouterConstants.explore,
    RouterConstants.chatWelcome,
    RouterConstants.profile,
  ];

  @override
  void initState() {
    super.initState();
    _loadUserEmail();
  }

  Future<void> _loadUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      userEmail = prefs.getString('userEmail') ?? 'Usuario';
    });
  }

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
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
              // 🎉 Imagen principal con superposición y botón
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
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: LinearGradient(
                          colors: [Colors.black.withOpacity(0.3), Colors.transparent],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 15,
                    child: Text(
                      'Nuevo evento en Cancún 🎉',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        shadows: [Shadow(blurRadius: 6, color: Colors.black)],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    right: 15,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () => context.go(RouterConstants.explore),
                      child: const Text('Ver', style: TextStyle(fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // 👋 Bienvenida destacada con email dinámico
              Text(
                'Bienvenido, $userEmail!',
                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              const SizedBox(height: 5),
              Text(
                'Descubre los mejores lugares gastronómicos de México.',
                style: TextStyle(fontSize: 14, color: Colors.grey.shade700),
              ),

              const SizedBox(height: 24),
              const Text(
                '⚡ Acceso rápido',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Colors.black87),
              ),
              const SizedBox(height: 12),

              // 🔗 Tarjetas de acceso con diseño atractivo
              QuickAccessCard(
                title: 'Eventos especiales',
                subtitle: 'Exclusive dining experiences.',
                description: 'No te pierdas eventos únicos como ferias...',
                imageUrl: 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092',
                onPressed: () => context.go('/eventos'),
              ),
              QuickAccessCard(
                title: 'Chat',
                subtitle: 'Soporte y comunidad.',
                description: 'Conéctate con nuestro equipo o con viajeros para compartir experiencias.',
                imageUrl: 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092',
                onPressed: () => context.go('/chat'),
              ),
              QuickAccessCard(
                title: 'Establecimientos',
                subtitle: 'Restaurantes disponibles.',
                description: 'Explora los mejores lugares recomendados cerca de ti.',
                imageUrl: 'https://images.unsplash.com/photo-1600891964599-f61ba0e24092',
                onPressed: () => context.go('/establecimiento'),
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
  final String description;
  final String imageUrl;
  final VoidCallback onPressed;

  const QuickAccessCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.imageUrl,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOut,
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.85),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.08),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.network(
            imageUrl,
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.black87),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Text(subtitle, style: TextStyle(fontSize: 13, color: Colors.grey)),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.teal),
        onTap: onPressed,
      ),
    );
  }
}
