import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HistorialPage extends StatefulWidget {
  const HistorialPage({super.key});

  @override
  State<HistorialPage> createState() => _HistorialPageState();
}

class _HistorialPageState extends State<HistorialPage> {
  final List<Map<String, String>> historial = [
    {
      'image': 'https://149391556.v2.pressablecdn.com/wp-content/uploads/2020/11/DSCF6047-scaled.jpg',
      'fecha': '01/07/2025',
      'lugar': 'Oaxaca',
      'comentario': 'Un lugar muy agradable',
    },
    {
      'image': 'https://a.travel-assets.com/findyours-php/viewfinder/images/res70/245000/245511-Chiapas.jpg',
      'fecha': '28/06/2025',
      'lugar': 'San Cristóbal',
      'comentario': 'Excelente comida y arquitectura',
    },
    {
      'image': 'https://mbmarcobeteta.com/wp-content/uploads/2021/06/shutterstock_228270220-scaled.jpg',
      'fecha': '20/06/2025',
      'lugar': 'Palenque',
      'comentario': 'Historia maya y naturaleza',
    },
    {
      'image': 'https://149391556.v2.pressablecdn.com/wp-content/uploads/2020/11/DSCF6047-scaled.jpg',
      'fecha': '01/07/2025',
      'lugar': 'Oaxaca',
      'comentario': 'Un lugar muy agradable',
    },
    {
      'image': 'https://a.travel-assets.com/findyours-php/viewfinder/images/res70/245000/245511-Chiapas.jpg',
      'fecha': '28/06/2025',
      'lugar': 'San Cristóbal',
      'comentario': 'Excelente comida y arquitectura',
    },
    {
      'image': 'https://mbmarcobeteta.com/wp-content/uploads/2021/06/shutterstock_228270220-scaled.jpg',
      'fecha': '20/06/2025',
      'lugar': 'Palenque',
      'comentario': 'Historia maya y naturaleza',
    },
  ];


  int _selectedIndex = 3;

  final List<String> _routes = [
    '/home',
    '/explore',
    '/chat',
    '/profile',
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    context.go(_routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F9F3),
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
      body: Stack(
        children: [
          // Fondo degradado
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFFF0F9F3), Color(0xFFE1F5EC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),

          // Ondas decorativas
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.network(
              'https://i.imgur.com/VqkZhz5.png',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),
          Positioned(
            bottom: 60, // para no tapar el navbar
            left: 0,
            right: 0,
            child: Image.network(
              '',
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const SizedBox(),
            ),
          ),

          // Contenido principal
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 55),
                  const Text(
                    'Historial de búsqueda',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: ListView.builder(
                      itemCount: historial.length,
                      itemBuilder: (context, index) {
                        final item = historial[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.06),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  bottomLeft: Radius.circular(16),
                                ),
                                child: Image.network(
                                  item['image'] ?? '',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                  errorBuilder: (_, __, ___) =>
                                  const Icon(Icons.image_not_supported),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item['lugar'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        item['comentario'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black87,
                                        ),
                                      ),
                                      const SizedBox(height: 6),
                                      Text(
                                        item['fecha'] ?? '',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
