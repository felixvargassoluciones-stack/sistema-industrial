class UserModel {
  final String id;
  final String nombre;
  final String correo;
  final String rol; // 'administrador' o 'cliente'

  UserModel({
    required this.id,
    required this.nombre,
    required this.correo,
    required this.rol,
  });

  // Convierte la respuesta JSON de Google Sheets en un objeto de Dart
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      nombre: json['nombre'] ?? '',
      correo: json['correo'] ?? '',
      rol: json['rol'] ?? 'cliente', // Por defecto asignamos cliente
    );
  }
}
