class UserModel {
  final int id;
  final String nombre;
  final String email;

  UserModel({
    required this.id,
    required this.nombre,
    required this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      nombre: json['nombre'],
      email: json['email'],
    );
  }
}