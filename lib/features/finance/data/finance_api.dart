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
      final res = await _dio.get('economy/borsaIstanbul');

      final d = _normalizedData(res.data);
      if (d is Map) {
        final result = d['result'];
        if (result is Map) {
          return BistIndexModel.fromMap(Map<String, dynamic>.from(result));
        }
        if (result is List && result.isNotEmpty) {
          final first = result.first;
          if (first is Map) {
            return BistIndexModel.fromMap(Map<String, dynamic>.from(first));
          }
        }
        final msg = d['message']?.toString() ?? 'BIST verisi alınamadı';
        throw Exception(msg);
      }

      throw Exception('Geçersiz yanıt');
    } catch (e) {
      throw Exception('getBistIndex failed: $e');
    }
  }
}
