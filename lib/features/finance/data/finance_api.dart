import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app/core/dio_client.dart';
import 'package:news_app/features/finance/data/models/bist_index_model.dart';

class FinanceApi {
  final Dio _dio = DioClient.instance.dio;

  //İsteğe bağlı küçük yardımcılar(res.data string gelebilir)
  dynamic _normalizedData(dynamic data) {
    if (data is String) {
      if (data.trim().isEmpty) return {};
      try {
        return jsonDecode(data);
      } catch (_) {
        return {};
      }
    }
    return data;
  }

  Map<String, dynamic> _unwrapResultMap(dynamic data) {
    final d = _normalizedData(data);
    if (d is Map && d['result'] is Map) {
      return Map<String, dynamic>.from(d['result'] as Map);
    }
    return <String, dynamic>{};
  }

  /// BIST 100 Endeksi (borsaIstanbul)
  Future<BistIndexModel> getBistIndex() async {
    try {
      final res = await _dio.get('/economy/borsaIstanbul');
      final map = _unwrapResultMap(res.data);
      if (map.isEmpty) throw Exception('BIST verisi alınamadı');
      return BistIndexModel.fromMap(map);
    } catch (e) {
      throw Exception('getBistIndex failed: $e');
    }
  }
}
