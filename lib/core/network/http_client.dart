import 'package:dio/dio.dart';

class HttpClient {
  final Dio dio;

  HttpClient()
      : dio = Dio(BaseOptions(
<<<<<<< HEAD
          baseUrl: 'http://44.207.222.107:8000/', 
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
          },
        ));
}
=======
    baseUrl: 'http://44.207.222.107:8000/',
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
    headers: {
      'Content-Type': 'application/json',
    },
  ));
}
>>>>>>> 2a8a2670ed3cd7a96ed935c3658cab3e8347b3a2
