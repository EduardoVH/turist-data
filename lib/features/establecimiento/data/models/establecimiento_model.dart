class Establecimiento {
  final String id;
  final String nombre;
  final String direccion;
  final String categoria;
  final String imagen;
  final String horario;
  final String precio;
  final double? latitude;
  final double? longitude;

  Establecimiento({
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

  factory Establecimiento.fromJson(Map<String, dynamic> json) {
    return Establecimiento(
      id: json['_id'] ?? '',
      nombre: json['nombre'] ?? '',
      direccion: json['direccion'] ?? '',
      categoria: json['categoria'] ?? '',
      imagen: json['imagen'] ?? '',
      horario: json['horario'],
      precio: json['precio'],
      latitude: json['latitude'] != null ? (json['latitude'] as num).toDouble() : null,
      longitude: json['longitude'] != null ? (json['longitude'] as num).toDouble() : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nombre': nombre,
      'direccion': direccion,
      'categoria': categoria,
      'imagen': imagen,
      'horario': horario,
      'precio': precio,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}
