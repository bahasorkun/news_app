import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app/core/dio_client.dart';
import 'package:news_app/features/pharmacy/data/models/pharmacy_model.dart';

class PharmacyApi {
  final Dio _dio = DioClient.instance.dio;

  // 1) Nöbetçi eczaneler (zaten var)
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
      throw Exception("Eczaneler alınamadı: $e");
    }
  }

  // 2) İlçeleri getir (şehir parametresiyle)
  Future<List<String>> getDistricts(String city) async {
    try {
      final res = await _dio.get(
        '/health/districtList',
        queryParameters: {'il': city},
      );

      dynamic data = res.data;
      if (data is String) data = jsonDecode(data);

      final rawList = (data is Map && data['result'] is List)
          ? data['result'] as List
          : const [];

      return rawList.map((e) => e.toString()).toList();
    } catch (e) {
      throw Exception("İlçeler alınamadı: $e");
    }
  }

  // 3) (Opsiyonel) KKTC şehirleri
  Future<List<String>> getKktcCities() async {
    try {
      final res = await _dio.get('/health/kktcCityList');
      dynamic data = res.data;
      if (data is String) data = jsonDecode(data);

      final rawList = (data is Map && data['result'] is List)
          ? data['result'] as List
          : const [];

      return rawList.map((e) => e.toString()).toList();
    } catch (e) {
      throw Exception("KKTC şehirleri alınamadı: $e");
    }
  }

  // 4) (Opsiyonel) KKTC eczaneleri
  Future<List<PharmacyModel>> getKktcDutyPharmacies(String city) async {
    try {
      final res = await _dio.get(
        '/health/kktcDutyPharmacy',
        queryParameters: {'il': city},
      );

      dynamic data = res.data;
      if (data is String) data = jsonDecode(data);

      final rawList = (data is Map && data['result'] is List)
          ? data['result'] as List
          : const [];

      return rawList
          .map((e) => PharmacyModel.fromMap(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception("KKTC eczaneleri alınamadı: $e");
    }
  }
}
