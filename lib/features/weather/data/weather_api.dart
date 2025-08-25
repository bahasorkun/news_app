import 'package:dio/dio.dart';
import 'package:news_app/core/dio_client.dart';
import 'package:news_app/features/weather/data/models/weather_model.dart';

class WeatherApi {
  final Dio _dio = DioClient.instance.dio;
  Future<List<WeatherModel>> getWeather(String city) async {
    try {
      final res = await _dio.get(
        'weather/getWeather',
        queryParameters: {'city': city, 'lang': "tr"},
      );
      final list = (res.data['result'] as List?) ?? [];
      return list
          .map((e) => WeatherModel.fromMap(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      throw Exception("Hava durumu alınamadı : ${e.message}");
    } catch (e) {
      throw Exception("Hava durumu alınamadı : $e");
    }
  }
}
