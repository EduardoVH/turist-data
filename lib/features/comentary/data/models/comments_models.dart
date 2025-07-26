class Comment {
  final String nombre;
  final String ciudad;
  final String comentario;
  final String fecha;
  final double rating;

  Comment({
    required this.nombre,
    required this.ciudad,
    required this.comentario,
    required this.fecha,
    required this.rating,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      nombre: json['nombre'] ?? 'Anónimo',
      ciudad: json['ciudad'] ?? 'Desconocida',
      comentario: json['comentario'] ?? '',
      fecha: json['fecha'] ?? '',
      rating: (json['rating'] != null)
          ? double.tryParse(json['rating'].toString()) ?? 0
          : 0,
    );
  }
}
