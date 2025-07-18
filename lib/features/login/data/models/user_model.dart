class UserModel {
  final int id;
  final String nombre;
  final String correo;

  UserModel({
    required this.id,
    required this.nombre,
    required this.correo,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nombre: json['nombre'],
      correo: json['correo'],
    );
  }
}