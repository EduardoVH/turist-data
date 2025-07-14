class ApiConfig {
  // TODO: Cambia esta URL por la URL real de tu API
  static const String baseUrl = 'http://192.168.56.1:3000';

  // Endpoints
  static const String loginEndpoint = '/api/auth/login';
  static const String registerEndpoint = '/api/auth/register';
  static const String productsEndpoint = '/api/productos';

  // Configuración de timeout
  static const Duration timeout = Duration(seconds: 30);
}