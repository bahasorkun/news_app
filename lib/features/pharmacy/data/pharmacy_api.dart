import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app/core/dio_client.dart';
import 'package:news_app/features/pharmacy/data/models/pharmacy_model.dart';

class PharmacyApi {
  final Dio _dio = DioClient.instance.dio;
  Future<List<PharmacyModel>> getDutyPharmacies({
    required String city,
    required String district,
  }) async {
    try {
      final res = await _dio.get(
        '/health/dutyPharmacy',
        queryParameters: {'il': city, 'ilce': district},
      );

      dynamic data = res.data;
      if (data is String) {
        data = data.isEmpty ? '{}' : jsonDecode(data);
      }

      final rawList = (data is Map && data['result'] is List)
          ? data['result'] as List
          : (data is List ? data : const []);

      return rawList
          .map((e) => PharmacyModel.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("Eczaneler Alınamadı ");
    }
  }
}
