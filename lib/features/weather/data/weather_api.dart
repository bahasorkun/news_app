import 'dart:convert';

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
      dynamic data = res.data;
      // Normalize data
      if (data is String) {
        // Try to parse as JSON
        try {
          data = jsonDecode(data);
        } catch (_) {
          data = {};
        }
      }
      List<dynamic> list = [];
      if (data is Map && data.containsKey('result')) {
        if (data['result'] is List) {
          list = data['result'];
        }
      } else if (data is List) {
        list = data;
      }
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
