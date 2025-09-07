import 'package:dio/dio.dart';
import 'package:news_app/core/dio_client.dart';
import 'package:news_app/features/football/data/models/goal_king_item.dart';
import 'package:news_app/features/football/data/models/league_item.dart';
import 'package:news_app/features/football/data/models/result_item.dart';
import 'package:news_app/features/football/data/models/standing_item.dart';

class FootballApi {
  final Dio _dio = DioClient.instance.dio;

  Future<List<LeagueItem>> getLeagues() async {
    try {
      final res = await _dio.get('football/leaguesList');
      final list = (res.data['result'] as List?) ?? [];
      return list
          .map((e) => LeagueItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final msg =
          e.response?.data is Map && (e.response!.data['message'] != null)
          ? e.response!.data['message'].toString()
          : e.message ?? 'Bilinmeyen Hata';
      throw Exception('Lig listesi alınamadı: $msg');
    } catch (e) {
      throw Exception('Lig listesi alınamadı: $e');
    }
  }

  Future<List<ResultItem>> getResults(String leagueKey) async {
    try {
      final res = await _dio.get(
        'football/results',
        queryParameters: {'data.league': leagueKey},
      );
      final list = (res.data['result'] as List?) ?? [];
      return list
          .map((e) => ResultItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final msg =
          e.response?.data is Map && (e.response!.data['message'] != null)
          ? e.response!.data['message'].toString()
          : e.message ?? 'Bilinmeyen Hata';
      throw Exception('Sonuçlar alınamadı: $msg');
    } catch (e) {
      throw Exception('Sonuçlar alınamadı: $e');
    }
  }

  Future<List<StandingItem>> getLeagueTable(String leagueKey) async {
    try {
      final res = await _dio.get(
        'football/league',
        queryParameters: {'data.league': leagueKey},
      );
      final list = (res.data['result'] as List?) ?? [];
      return list
          .map((e) => StandingItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final msg =
          e.response?.data is Map && (e.response!.data['message'] != null)
          ? e.response!.data['message'].toString()
          : e.message ?? 'Bilinmeyen Hata';
      throw Exception('Puan durumu alınamadı: $msg');
    } catch (e) {
      throw Exception('Puan durumu alınamadı: $e');
    }
  }

  Future<List<GoalKingItem>> getGoalKings(String leagueKey) async {
    try {
      final res = await _dio.get(
        'football/goalKings',
        queryParameters: {'data.league': leagueKey},
      );
      final list = (res.data['result'] as List?) ?? [];
      return list
          .map((e) => GoalKingItem.fromJson(e as Map<String, dynamic>))
          .toList();
    } on DioException catch (e) {
      final msg =
          e.response?.data is Map && (e.response!.data['message'] != null)
          ? e.response!.data['message'].toString()
          : e.message ?? 'Bilinmeyen Hata';
      throw Exception('Gol krallığı alınamadı: $msg');
    } catch (e) {
      throw Exception('Gol krallığı alınamadı: $e');
    }
  }
}
