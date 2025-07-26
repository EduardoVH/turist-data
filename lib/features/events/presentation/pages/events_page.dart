import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:dio/dio.dart';
import 'package:turist_data/core/di/injection.dart';
import 'package:turist_data/features/events/presentation/bloc/eventos_bloc.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<EventosBloc>(
      create: (_) => sl<EventosBloc>()..add(LoadEventosEspeciales()),
      child: Scaffold(
        backgroundColor: const Color(0xFFF0F9F3),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Column(
            children: [
              const Text(
                '🎉 Eventos Especiales',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 6),
              Container(
                height: 4,
                width: 80,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.teal, Colors.teal.shade100],
                  ),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => context.go('/home'),
          ),
        ),
        body: BlocBuilder<EventosBloc, EventosState>(
          builder: (context, state) {
            if (state is EventosLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is EventosLoaded) {
              final eventos = state.eventos;
              if (eventos.isEmpty) {
                return const Center(child: Text('No hay eventos registrados.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                itemCount: eventos.length,
                itemBuilder: (context, index) {
                  final evento = eventos[index];
                  return AnimatedOpacity(
                    duration: const Duration(milliseconds: 400),
                    opacity: 1.0,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: EventCard(data: evento),
                    ),
                  );
                },
              );
            } else if (state is EventosError) {
              return Center(child: Text('Error: ${state.message}'));
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: 2,
          selectedItemColor: Colors.teal,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            final routes = ['/home', '/explore', '/eventos', '/chat', '/profile'];
            context.go(routes[index]);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Inicio'),
            BottomNavigationBarItem(icon: Icon(Icons.explore), label: 'Explorar'),
            BottomNavigationBarItem(icon: Icon(Icons.event), label: 'Eventos'),
            BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Chat'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Perfil'),
          ],
        ),
      ),
    );
  }
}

class EventCard extends StatelessWidget {
  final Map<String, dynamic> data;
  const EventCard({super.key, required this.data});

  Color getEstadoColor(String estado) {
    switch (estado.toLowerCase()) {
      case 'activo':
        return Colors.green;
      case 'próximo':
        return Colors.orange;
      case 'finalizado':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final estadoEvento = data['estado'] ?? 'Desconocido';
    final estadoColor = getEstadoColor(estadoEvento);

    // Aquí usamos id_lugar en vez de id_destino
    final idLugar = data['id_lugar'] ?? 'N/A';

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.15),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: ExpansionTile(
            tilePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            childrenPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            title: Row(
              children: [
                Expanded(
                  child: Text(
                    data['nombre'] ?? 'Sin título',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Colors.teal,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Chip(
                  label: Text(
                    estadoEvento,
                    style: const TextStyle(color: Colors.white),
                  ),
                  backgroundColor: estadoColor,
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 6),
              child: Text(
                data['descripcion'] ?? 'Sin descripción',
                style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
              ),
            ),
            trailing: const Icon(Icons.expand_more, color: Colors.teal),
            children: [
              Row(
                children: [
                  const Expanded(child: Divider()),
                  const Icon(Icons.star, color: Colors.teal),
                  const Expanded(child: Divider()),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.place, size: 20, color: Colors.teal),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Chip(
                      label: Text(
                        idLugar.toString(),
                        style: const TextStyle(color: Colors.teal),
                        overflow: TextOverflow.ellipsis,
                      ),
                      backgroundColor: Colors.teal.shade50,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.calendar_today_outlined, size: 18, color: Colors.teal),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'Inicio: ${data['fecha_inicio'] ?? 'N/D'}',
                                style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.flag, size: 18, color: Colors.teal),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                'Fin: ${data['fecha_final'] ?? 'N/D'}',
                                style: const TextStyle(color: Colors.black87, fontWeight: FontWeight.w500),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
