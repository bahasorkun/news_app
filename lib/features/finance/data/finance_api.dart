import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:news_app/core/dio_client.dart';
import 'package:news_app/features/finance/data/models/bist_index_model.dart';
import 'package:news_app/features/finance/data/models/currency_model.dart';

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

  /// Döviz Kurları (allCurrency)
  Future<List<CurrencyModel>> getCurrencies() async {
    try {
      final res = await _dio.get('economy/allCurrency');
      final d = _normalizedData(res.data);
      final list = (d is Map && d['result'] is List)
          ? d['result'] as List
          : const [];
      return list
          .whereType<Map>()
          .map((e) => CurrencyModel.fromMap(Map<String, dynamic>.from(e)))
          .toList();
    } catch (e) {
      throw Exception('getCurrencies failed: $e');
    }
  }
}
