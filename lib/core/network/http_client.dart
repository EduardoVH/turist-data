import 'package:dio/dio.dart';

class HttpClient {
  final Dio dio;

  HttpClient()
      : dio = Dio(BaseOptions(
          baseUrl: 'http://44.207.222.107:8000/', 
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            'Content-Type': 'application/json',
          },
        ));
}
