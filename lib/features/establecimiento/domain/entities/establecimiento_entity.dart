class EstablecimientoEntity {
  final String id;
  final String nombre;
  final String direccion;
  final String categoria;
  final String imagen;
  final String horario;
  final String precio;
  final double? latitude;  // agrega estas
  final double? longitude; // propiedades opcionales

  EstablecimientoEntity({
    required this.id,
    required this.nombre,
    required this.direccion,
    required this.categoria,
    required this.imagen,
    required this.horario,
    required this.precio,
    this.latitude,
    this.longitude,
  });
}
