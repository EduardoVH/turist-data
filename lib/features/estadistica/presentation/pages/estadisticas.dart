import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class EstadisticasPage extends StatefulWidget {
  const EstadisticasPage({super.key});

  @override
  State<EstadisticasPage> createState() => _EstadisticasPageState();
}

class _EstadisticasPageState extends State<EstadisticasPage> {
  final Color backgroundColor = const Color(0xFFE6F2E6); // fondo verde claro
  int _selectedIndex = 1;

  final List<String> _routes = [
    '/establecimiento',
    '/estadisticas',
    '/profile',
  ];

  void _onItemTapped(int index) {
    if (_selectedIndex != index) {
      setState(() => _selectedIndex = index);
      context.go(_routes[index]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Dashboard'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Estadísticas'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Estadísticas de Visitas', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              const Text('Visitantes', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _StatCard(title: 'Total', value: '12,345', growth: '+12%'),
              _StatCard(title: 'Nuevos', value: '8,765', growth: '+8%'),
              _StatCard(title: 'Volvieron a visitar', value: '3,580', growth: '+15%'),

              const SizedBox(height: 30),
              const Text('Interés por Ubicación', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _LocationList(locations: ['San Francisco', 'Los Angeles', 'San Diego', 'Sacramento']),

              const SizedBox(height: 30),
              const Text('Estacionalidad', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 10),
              _SeasonChart(seasons: ['Primavera', 'Verano', 'Otoño', 'Invierno']),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final String growth;

  const _StatCard({required this.title, required this.value, required this.growth});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(255, 255, 255, 0.85),
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text('Crecimiento: $growth'),
        trailing: Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}

class _LocationList extends StatelessWidget {
  final List<String> locations;

  const _LocationList({required this.locations});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: locations.map((loc) => Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.85),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: const Icon(Icons.location_on, color: Colors.teal),
          title: Text(loc),
        ),
      )).toList(),
    );
  }
}

class _SeasonChart extends StatelessWidget {
  final List<String> seasons;

  const _SeasonChart({required this.seasons});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: seasons.map((season) => Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        decoration: BoxDecoration(
          color: const Color.fromRGBO(255, 255, 255, 0.85),
          borderRadius: BorderRadius.circular(12),
        ),
        child: ListTile(
          leading: const Icon(Icons.calendar_today, color: Colors.orange),
          title: Text(season),
        ),
      )).toList(),
    );
  }
}
