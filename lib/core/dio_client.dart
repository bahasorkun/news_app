import 'package:dio/dio.dart';

class DioClient {
  static final DioClient _instance = DioClient._internal();

  static DioClient get instance => _instance;

  late Dio dio;

  DioClient._internal() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.collectapi.com/",
        headers: {
          "authorization":
              "apikey 3gpnNGf6HyBWZ7pa9QR2aW:32mE8jNwJhWoEddfkXXQA5",
          "content-type": "application/json",
        },
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
      ),
    );
  }
}
