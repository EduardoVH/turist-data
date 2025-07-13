import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<String> filters = const [
    'Todos', 'Oaxaca', 'Yucatán', 'Quintana Roo', 'Chiapas'
  ];

  final List<Map<String, String>> destinations = const [
    {
      'title': 'Oaxaca',
      'subtitle': 'Oaxaca',
      'image': 'https://images.unsplash.com/photo-1570129477492-45c003edd2be'
    },
    {
      'title': 'Yucatán',
      'subtitle': 'Yucatán',
      'image': 'https://images.unsplash.com/photo-1586190848861-99aa4a171e90'
    },
    {
      'title': 'Quintana Roo',
      'subtitle': 'Quintana Roo',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e'
    },
    {
      'title': 'Chiapas',
      'subtitle': 'Chiapas',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e'
    },
    {
      'title': 'Ciudad de México',
      'subtitle': 'Ciudad de México',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e'
    },
    {
      'title': 'Puebla',
      'subtitle': 'Puebla',
      'image': 'https://images.unsplash.com/photo-1507525428034-b723cf961d3e'
    },
  ];

  int _selectedIndex = 1; // "Explorar" está activa al cargar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    final routes = [
      '/home',
      '/explore',
      '/eventos',
      '/chat',
      '/profile',
    ];

    context.go(routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F9F3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Destinos', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: filters.map((f) => Chip(label: Text(f))).toList(),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  ...List.generate(
                    destinations.length ~/ 2,
                        (i) {
                      final first = destinations[i * 2];
                      final second = (i * 2 + 1 < destinations.length)
                          ? destinations[i * 2 + 1]
                          : null;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: Row(
                          children: [
                            Expanded(child: DestinationCard(data: first)),
                            const SizedBox(width: 16),
                            if (second != null)
                              Expanded(child: DestinationCard(data: second))
                            else
                              const Expanded(child: SizedBox()),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Historial reciente",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 170,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: 4,
                      separatorBuilder: (_, __) => const SizedBox(width: 12),
                      itemBuilder: (context, i) {
                        final history = destinations[(destinations.length - 1) - i];
                        return SizedBox(
                          width: 140,
                          child: ClipRect(
                            child: SingleChildScrollView(
                              child: DestinationCard(data: history),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            )
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
          BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorar'),
          BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Eventos'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),

    );
  }
}

class DestinationCard extends StatelessWidget {
  final Map<String, String> data;
  const DestinationCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              data['image']!,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => const Center(child: Icon(Icons.broken_image)),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(data['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(data['subtitle']!, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
