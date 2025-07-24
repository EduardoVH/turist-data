import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart'; // LatLng
import 'package:go_router/go_router.dart';
import '../../../map/presentation/pages/map_page.dart';
import '../blocs/establecimiento_bloc.dart';
import '../blocs/establecimiento_event.dart';
import '../blocs/establecimiento_state.dart';
import 'package:turist_data/core/router/app_router.dart';
import 'package:turist_data/features/map/presentation/pages/map_page.dart';

class EstablecimientoHomePage extends StatefulWidget {
  const EstablecimientoHomePage({super.key});

  @override
  State<EstablecimientoHomePage> createState() => _EstablecimientoHomePageState();
}

class _EstablecimientoHomePageState extends State<EstablecimientoHomePage> {
  final Color backgroundColor = const Color(0xFFE6F2E6);
  int _selectedIndex = 0;

  final List<String> _routes = [
    RouterConstants.home,
    RouterConstants.explore,
    RouterConstants.chat,
    RouterConstants.profile,
  ];

  void _onItemTapped(int index) {
    setState(() => _selectedIndex = index);
    context.go(_routes[index]);
  }

  @override
  void initState() {
    super.initState();
    context.read<EstablecimientoBloc>().add(LoadEstablecimientos());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.teal),
          onPressed: () => context.go('/home'),
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
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFCCEDE6),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Bienvenidos',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Visualiza los restaurantes cerca de ti',
                      style: TextStyle(fontSize: 14, color: Colors.black87),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Establecimientos',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              BlocBuilder<EstablecimientoBloc, EstablecimientoState>(
                builder: (context, state) {
                  if (state is EstablecimientoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is EstablecimientoLoaded) {
                    return Column(
                      children: state.establecimientos.map((e) {
                        return _ExpandableEstablecimientoCard(
                          icon: Icons.place,
                          title: e.nombre,
                          subtitle: e.direccion,
                          latitude: e.latitude,
                          longitude: e.longitude,
                          horario: e.horario,
                          precio: e.precio,
                        );
                      }).toList(),
                    );
                  } else if (state is EstablecimientoError) {
                    return Text('Error: ${state.message}');
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ExpandableEstablecimientoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final double? latitude;
  final double? longitude;
  final String? horario;
  final String? precio;

  const _ExpandableEstablecimientoCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    this.latitude,
    this.longitude,
    this.horario,
    this.precio,
    Key? key,
  }) : super(key: key);

  @override
  State<_ExpandableEstablecimientoCard> createState() => _ExpandableEstablecimientoCardState();
}

class _ExpandableEstablecimientoCardState extends State<_ExpandableEstablecimientoCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final LatLng? location = (widget.latitude != null && widget.longitude != null)
        ? LatLng(widget.latitude!, widget.longitude!)
        : null;

    return GestureDetector(
      onTap: () => setState(() => _isExpanded = !_isExpanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          children: [
            // Imagen de fondo con gradiente y título
            ClipRRect(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(18)),
              child: Stack(
                children: [
                  Container(
                    height: 160,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: widget.subtitle.isNotEmpty
                        ? Image.network(
                      // Puedes cambiar aquí por imagen real si la tienes en datos
                      'https://images.unsplash.com/photo-1565299624946-b28f40a0ae38',
                      fit: BoxFit.cover,
                      errorBuilder: (_, __, ___) => const Icon(Icons.broken_image, size: 50),
                    )
                        : const SizedBox.shrink(),
                  ),
                  Container(
                    height: 160,
                    decoration: BoxDecoration(
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
                    child: Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black54,
                            blurRadius: 6,
                            offset: Offset(0, 2),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            AnimatedCrossFade(
              firstChild: const SizedBox.shrink(),
              secondChild: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(Icons.access_time, size: 20, color: Colors.teal),
                        const SizedBox(width: 10),
                        Text(
                          'Horario:',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.teal[700]),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            widget.horario ?? "No disponible",
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.attach_money, size: 20, color: Colors.teal),
                        const SizedBox(width: 10),
                        Text(
                          'Rango de precio:',
                          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.teal[700]),
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            widget.precio ?? "N/A",
                            style: const TextStyle(fontSize: 14, color: Colors.black87),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.location_on, size: 20, color: Colors.teal),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Dirección:',
                                style: TextStyle(fontWeight: FontWeight.w600, color: Colors.teal[700]),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                widget.subtitle,
                                style: const TextStyle(fontSize: 14, color: Colors.black87),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          final location = (widget.latitude != null && widget.longitude != null)
                              ? LatLng(widget.latitude!, widget.longitude!)
                              : null;

                          if (location != null) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => MapPage(
                                  title: widget.title,
                                  location: location,
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Coordenadas no disponibles")),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                          elevation: 6,
                        ),
                        icon: const Icon(Icons.map, size: 20),
                        label: const Text(
                          "Ver en mapa",
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              crossFadeState:
              _isExpanded ? CrossFadeState.showSecond : CrossFadeState.showFirst,
              duration: const Duration(milliseconds: 300),
            ),

            // Botón expandir/colapsar
            Container(
              decoration: BoxDecoration(
                color: Colors.teal.shade50,
                borderRadius: const BorderRadius.vertical(bottom: Radius.circular(18)),
              ),
              child: TextButton(
                onPressed: () => setState(() => _isExpanded = !_isExpanded),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(_isExpanded ? 'Ver menos' : 'Ver más',
                        style: const TextStyle(color: Colors.teal)),
                    Icon(
                      _isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                      color: Colors.teal,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
