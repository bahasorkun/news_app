import 'package:flutter/material.dart';
import 'package:news_app/features/weather/data/models/weather_model.dart';
import 'package:news_app/features/weather/data/weather_api.dart';
import 'package:news_app/features/weather/presentation/widgets/day_chip.dart';
import 'package:news_app/features/weather/presentation/widgets/today_card.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _api = WeatherApi();
  final _cityCtrl = TextEditingController();

  List<WeatherModel> _items = [];
  bool _loading = false;
  String? _error;
  String _cityTitle = 'Hava';

  @override
  void dispose() {
    _cityCtrl.dispose();
    super.dispose();
  }

  Future<void> _search(String raw) async {
    final query = raw.trim();
    if (query.isEmpty) return;
    setState(() {
      _loading = true;
      _error = null;
      _items = [];
      _cityTitle = query;
    });
    try {
      final list = await _api.getWeather(query);
      setState(() => _items = list);
    } catch (e) {
      setState(() => _error = 'Hava durumu alınamadı: $e');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // background gradient
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.indigo.shade300, Colors.indigo.shade700],
            ),
          ),
        ),
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _cityTitle,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _cityCtrl,
                  textInputAction: TextInputAction.search,
                  onSubmitted: _search,
                  decoration: InputDecoration(
                    hintText: 'Şehir adını giriniz',
                    hintStyle: const TextStyle(color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white24,
                    prefixIcon: const Icon(
                      Icons.location_city,
                      color: Colors.white70,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.search, color: Colors.white),
                      onPressed: () => _search(_cityCtrl.text),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  cursorColor: Colors.white,
                  style: const TextStyle(color: Colors.white),
                ),
                const SizedBox(height: 16),
                Expanded(child: _buildBody()),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (_error != null) {
      return Center(
        child: Text(
          _error!,
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white),
        ),
      );
    }
    if (_items.isEmpty) {
      return const Center(
        child: Text(
          'Hava durumu verisi alınamadı veya boş geldi.',
          style: TextStyle(color: Colors.white70),
          textAlign: TextAlign.center,
        ),
      );
    }

    final today = _items.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TodayCard(item: today),
        const SizedBox(height: 12),
        Expanded(
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: _items.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, i) => DayChip(item: _items[i]),
          ),
        ),
      ],
    );
  }
}
