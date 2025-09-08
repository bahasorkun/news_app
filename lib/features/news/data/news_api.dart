import 'package:dio/dio.dart';
import 'package:news_app/core/app_state.dart';
import 'package:news_app/core/dio_client.dart';
import 'package:news_app/features/news/data/models/news_model.dart';

class NewsApi {
  //Tek merkezden yönetilen dio
  final Dio _dio = DioClient.instance.dio;
  Future<List<NewsModel>> getNews({
    String? country,
    String tag = "general",
    int paging = 0,
  }) async {
    try {
      final lang = AppState.instance.locale?.languageCode;
      final countryCode = country ?? (lang == 'en' ? 'en' : 'tr');
      final res = await _dio.get(
        'news/getNews',
        queryParameters: {
          'country': countryCode,
          'tag': tag,
          'paging': paging.toString(),
        },
      );
      final list = (res.data['result'] as List?) ?? [];
      return list
          .map((e) => NewsModel.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final msg =
          e.response?.data is Map && (e.response!.data['message'] != null)
          ? e.response!.data['message'].toString()
          : e.message ?? 'Bilinmeyen Hata';
      throw Exception("Haberler Alınamadı : $msg");
    } catch (e) {
      throw Exception("Haberler alınamadı : $e");
    }
  }
}
