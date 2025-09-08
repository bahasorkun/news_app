import 'package:flutter/material.dart';
import 'package:news_app/core/l10n/app_localizations.dart';

class PreciousMetalsCard extends StatelessWidget {
  final String title; // Gram Altın, ONS Altın, Gümüş
  final double buy;
  final double sell;

  const PreciousMetalsCard({
    super.key,
    required this.title,
    required this.buy,
    required this.sell,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// Sol taraf: başlık
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),

            /// Sağ taraf: alış - satış
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "${AppLocalizations.of(context).t('buy')}: ${buy.toStringAsFixed(2)}",
                  style: TextStyle(color: Colors.grey[700]),
                ),
                Text(
                  "${AppLocalizations.of(context).t('sell')}: ${sell.toStringAsFixed(2)}",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
