class Comment {
  final String nombre;
  final String comentario;
  final String fecha;
  final String ciudad;
  final int rating;

  Comment({
    required this.nombre,
    required this.comentario,
    required this.fecha,
    required this.ciudad,
    required this.rating,
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      nombre: json['nombre'] ?? '',
      comentario: json['comentario'] ?? '',
      fecha: json['fecha'] ?? '',
      ciudad: json['ciudad'] ?? '',
      rating: json['estrellas_calificacion'] ?? 0,
    );
  }

  }
