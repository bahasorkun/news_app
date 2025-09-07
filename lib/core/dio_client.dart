import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app/core/env.dart' as env;

class DioClient {
  static final DioClient _instance = DioClient._internal();

  static DioClient get instance => _instance;

  late Dio dio;

  DioClient._internal() {
    // API anahtarını 3 kaynaktan sırayla dene:
    // 1) --dart-define=COLLECT_API_KEY
    // 2) lib/core/env.dart içindeki collectApiKey
    // 3) fallback (demo key)
    const defineKey =
        String.fromEnvironment('COLLECT_API_KEY', defaultValue: '');
    final fileKey = env.collectApiKey;
    final rawKey = defineKey.trim().isNotEmpty
        ? defineKey.trim()
        : fileKey.trim();

    final authHeader = rawKey.isNotEmpty
        ? (rawKey.startsWith('apikey') ? rawKey : 'apikey $rawKey')
        : "apikey 3gpnNGf6HyBWZ7pa9QR2aW:32mE8jNwJhWoEddfkXXQA5"; // fallback

    // Debug'da hangi key kaynağının kullanıldığını tek satır logla
    if (kDebugMode) {
      final reg = RegExp(r"([A-Za-z0-9]{4})([A-Za-z0-9]+)([A-Za-z0-9]{4})");
      final masked = authHeader
          .replaceAll(RegExp(r"apikey\s*"), "apikey ")
          .replaceAllMapped(reg, (m) => "${m.group(1)}...${m.group(3)}");
      final source = defineKey.trim().isNotEmpty
          ? 'define'
          : (fileKey.trim().isNotEmpty ? 'env' : 'fallback');
      // ignore: avoid_print
      print("CollectAPI key source=$source, header=$masked");
    }

    dio = Dio(
      BaseOptions(
        baseUrl: "https://api.collectapi.com/",
        headers: {
          "authorization": authHeader,
          "content-type": "application/json",
        },
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        responseType: ResponseType.json,
      ),
    );
    // Ağ loglarını sadece debug derlemelerde aç
    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          requestBody: false,
          responseBody: false,
          requestHeader: false,
          responseHeader: false,
        ),
      );
    }
  }
}
