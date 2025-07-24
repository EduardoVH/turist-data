import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;

class ExplorePage extends StatefulWidget {
  const ExplorePage({super.key});

  @override
  State<ExplorePage> createState() => _ExplorePageState();
}

class _ExplorePageState extends State<ExplorePage> {
  final List<String> filters = const [
    'Aguascalientes',
    'Baja California',
    'Baja California Sur',
    'Campeche',
    'Chiapas',
    'Chihuahua',
    'CDMX',
    'Coahuila',
    'Colima',
    'Durango',
    'Guanajuato',
    'Guerrero',
    'Hidalgo',
    'Jalisco',
    'Edo. México',
    'Michoacán',
    'Morelos',
    'Nayarit',
    'Nuevo León',
    'Oaxaca',
    'Puebla',
    'Querétaro',
    'Quintana Roo',
    'San Luis Potosí',
    'Sinaloa',
    'Sonora',
    'Tabasco',
    'Tamaulipas',
    'Tlaxcala',
    'Veracruz',
    'Yucatán',
    'Zacatecas'
  ];

  List<Map<String, dynamic>> establecimientos = [];
  String selectedState = 'CDMX';
  int _selectedIndex = 1;
  bool isLoading = false;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    fetchEstablecimientos(selectedState);
  }

  Future<void> fetchEstablecimientos(String estado) async {
    setState(() {
      isLoading = true;
      errorMessage = '';
      establecimientos = [];
    });

    final uri = Uri.parse(
        'https://turistdata-back.onrender.com/api/establecimientos/estado?estado=${Uri.encodeComponent(estado)}');

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        setState(() {
          establecimientos =
              data.map((e) => e as Map<String, dynamic>).toList();
        });
      } else {
        setState(() {
          errorMessage = 'Error al cargar datos: código ${response.statusCode}';
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error en la conexión: $e';
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onItemTapped(int index) {
    final routes = ['/home', '/explore', '/eventos', '/chat', '/profile'];
    setState(() => _selectedIndex = index);
    context.go(routes[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: const Color(0xFFF0F9F3),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  const Text(
                    'Explora México',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      shape: BoxShape.circle,
                      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 6)],
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 160,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: filters.map((estado) {
                      final isSelected = estado == selectedState;
                      return ChoiceChip(
                        label: Text(
                          estado,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        selected: isSelected,
                        selectedColor: Colors.teal,
                        backgroundColor: Colors.grey.shade200,
                        onSelected: (_) {
                          if (selectedState != estado) {
                            setState(() {
                              selectedState = estado;
                            });
                            fetchEstablecimientos(estado);
                          }
                        },
                      );
                    }).toList(),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : errorMessage.isNotEmpty
                  ? Center(child: Text(errorMessage))
                  : establecimientos.isEmpty
                  ? const Center(child: Text('No se encontraron establecimientos.'))
                  : ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: establecimientos.length,
                itemBuilder: (_, index) {
                  final est = establecimientos[index];
                  return DestinationCard(data: est);
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: BottomNavigationBar(
            backgroundColor: Colors.white.withOpacity(0.9),
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.teal.shade700,
            unselectedItemColor: Colors.grey.shade500,
            type: BottomNavigationBarType.fixed,
            onTap: _onItemTapped,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
              BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorar'),
              BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Eventos'),
              BottomNavigationBarItem(icon: Icon(Icons.chat), label: 'Chat'),
              BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Perfil'),
            ],
          ),
        ),
      ),
    );
  }
}

class DestinationCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final bool compact;
  const DestinationCard({super.key, required this.data, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final title = data['nombre'] ?? 'Sin nombre';
    final direccion = data['direccion'] ?? '';
    final ciudad = data['ciudad'] ?? '';
    final estado = data['estado'] ?? '';
    final tipo = data['tipo'] ?? '';
    final horario = data['horario'] ?? '';
    final precio = data['precio'] ?? '';
    final imageUrl = data['imagen'] ?? 'https://via.placeholder.com/150';

    return GestureDetector(
      onTap: () {
        // Aquí puedes navegar a una página de detalle si quieres
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        height: compact ? 160 : 240,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(18),
              child: Image.network(
                imageUrl,
                height: double.infinity,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                const Icon(Icons.broken_image, size: 50),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                gradient: LinearGradient(
                  colors: [Colors.black.withOpacity(0.6), Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              bottom: 16,
              left: 16,
              right: 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (direccion.isNotEmpty || ciudad.isNotEmpty || estado.isNotEmpty)
                    Text(
                      [direccion, ciudad, estado].where((e) => e.isNotEmpty).join(', '),
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  if (tipo.isNotEmpty)
                    Text(
                      'Tipo: $tipo',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  if (horario.isNotEmpty)
                    Text(
                      'Horario: $horario',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  if (precio.isNotEmpty)
                    Text(
                      'Precio: \$${precio}',
                      style: const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
