import 'package:flutter/material.dart';
import 'package:news_app/features/weather/data/weather_api.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _api = WeatherApi();
  String city = "Elazig";
  Future<void> _testWeather() async {
    try {
      final list = await _api.getWeather(city);
      print("Toplam Gün : ${list.length}");
      if (list.isNotEmpty) {
        final t = list.first;
        print(
          "Bugün $city için hava durumu : ${t.date}, ${t.day},${t.status} , ${t.description} * ${t.degree} * Nem ${t.humidity}",
        );
      }
    } catch (e) {
      print("Hata: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: _testWeather,
        child: Text("Weather TEST"),
      ),
    );
  }
}
