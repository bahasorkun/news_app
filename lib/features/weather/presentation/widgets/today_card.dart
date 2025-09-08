import 'package:flutter/material.dart';
import 'package:news_app/features/weather/data/models/weather_model.dart';
import 'package:news_app/core/l10n/app_localizations.dart';

class TodayCard extends StatelessWidget {
  const TodayCard({super.key, required this.item});
  final WeatherModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .15),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        // 🔥 burayı Row yapıyoruz
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ikon
          Image.network(item.icon, width: 56, height: 56, color: Colors.white),
          const SizedBox(width: 12),

          // sağ taraf (açıklama + sıcaklıklar)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.description,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 12,
                  runSpacing: 6,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      '${item.degree.toStringAsFixed(0)}°',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${AppLocalizations.of(context).t('max')} ${item.max.toStringAsFixed(0)}°  •  ${AppLocalizations.of(context).t('min')} ${item.min.toStringAsFixed(0)}°',
                      style: const TextStyle(color: Colors.white70),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.water_drop,
                          color: Colors.white70,
                          size: 20,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${AppLocalizations.of(context).t('humidity')} %${item.humidity.toStringAsFixed(0)}',
                          style: const TextStyle(color: Colors.white70),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
