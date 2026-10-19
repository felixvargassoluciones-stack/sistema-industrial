import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import '../constants/api_constants.dart';

class ApiClient {
  final http.Client _client = http.Client();

  // Encabezados globales para evitar problemas de CORS y asegurar formato JSON
  final Map<String, String> _headers = {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  /// Método genérico para realizar peticiones POST seguras a la Google Web App
  Future<Map<String, dynamic>> post(Map<String, dynamic> body) async {
    try {
      final response = await _client.post(
        Uri.parse(ApiConstants.baseUrl),
        headers: _headers,
        body: jsonEncode(body),
      ).timeout(const Duration(seconds: 15)); // Tiempo límite de espera

      if (response.statusCode == 200 || response.statusCode == 302) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        return {
          'success': false,
          'mensaje': 'Error en el servidor: Código ${response.statusCode}'
        };
      }
    } on SocketException {
      // Intercepta de forma limpia la falta de internet en el dispositivo
      return {
        'success': false,
        'mensaje': 'No hay conexión a Internet. Verifica tu red.'
      };
    } on HttpException {
      return {
        'success': false,
        'mensaje': 'No se pudo establecer la conexión con el servidor.'
      };
    } catch (e) {
      return {
        'success': false,
        'mensaje': 'Ocurrió un error inesperado: $e'
      };
    }
  }

  /// Método genérico para obtener la lista de requerimientos (GET)
  Future<Map<String, dynamic>> get() async {
    try {
      final response = await _client.get(
        Uri.parse(ApiConstants.baseUrl),
        headers: _headers,
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        return jsonDecode(response.body) as Map<String, dynamic>;
      } else {
        return {
          'success': false,
          'mensaje': 'Error al obtener datos: Código ${response.statusCode}'
        };
      }
    } on SocketException {
      return {
        'success': false,
        'mensaje': 'No hay conexión a Internet para cargar los datos.'
      };
    } catch (e) {
      return {
        'success': false,
        'mensaje': 'Error inesperado al leer los datos: $e'
      };
    }
  }
}
