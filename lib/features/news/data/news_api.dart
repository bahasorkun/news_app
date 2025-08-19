import 'package:dio/dio.dart';
import 'package:news_app/core/dio_client.dart';

class NewsApi {
  //Tek merkezden yönetilen dio 
  final Dio _dio = DioClient.instance.dio;
}
