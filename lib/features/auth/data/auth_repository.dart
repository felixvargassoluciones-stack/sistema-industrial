import '../../../core/constants/api_constants.dart';
import '../../../core/network/api_client.dart';
import 'user_model.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient();

  /// Envía las credenciales a Google Apps Script para validar el inicio de sesión
  Future<Map<String, dynamic>> login(String correo, String contrasena) async {
    // Estructuramos el cuerpo de la petición con la acción que espera nuestro script
    final Map<String, dynamic> body = {
      'accion': ApiConstants.actionLogin,
      'correo': correo,
      'contrasena': contrasena,
    };

    final respuesta = await _apiClient.post(body);

    if (respuesta['success'] == true && respuesta['usuario'] != null) {
      // Si la validación es correcta, transformamos los datos al molde del modelo
      final usuario = UserModel.fromJson(respuesta['usuario']);
      return {
        'success': true,
        'usuario': usuario,
        'mensaje': respuesta['mensaje'] ?? 'Bienvenido'
      };
    } else {
      // Retorna el mensaje de error controlado desde la nube o por fallo de red
      return {
        'success': false,
        'mensaje': respuesta['mensaje'] ?? 'Error al iniciar sesión'
      };
    }
  }

  /// Registra un nuevo usuario en la hoja de cálculo de Google
  Future<Map<String, dynamic>> registrarUsuario({
    required String nombre,
    required String correo,
    required String contrasena,
    required String rol, // 'administrador' o 'cliente'
  }) async {
    final Map<String, dynamic> body = {
      'accion': ApiConstants.actionRegister,
      'nombre': nombre,
      'correo': correo,
      'contrasena': contrasena,
      'rol': rol,
    };

    return await _apiClient.post(body);
  }
}
