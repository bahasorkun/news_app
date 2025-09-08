import 'package:flutter/material.dart';
import 'package:news_app/core/l10n/app_localizations.dart';

class EmtiaCard extends StatelessWidget {
  final String name; // e.g., Kahve
  final double sellingUsd; // e.g., 386.10
  final double changePercent; // e.g., 64.98 or -0.64

  const EmtiaCard({
    super.key,
    required this.name,
    required this.sellingUsd,
    required this.changePercent,
  });

  String _formatUsdTr(double v) {
    final fixed = v.toStringAsFixed(2); // 386.10
    return fixed.replaceAll('.', ','); // 386,10
  }

  String _formatPercentTr(double v) {
    final fixed = v.abs().toStringAsFixed(2).replaceAll('.', ',');
    final sign = v >= 0 ? '' : '-';
    return '$sign$fixed%';
  }

  @override
  Widget build(BuildContext context) {
    final positive = changePercent >= 0;
    final color = positive ? Colors.green : Colors.red;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                name,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '${AppLocalizations.of(context).t('sell')}: ${_formatUsdTr(sellingUsd)}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                ),
                const Text(
                  'USD',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            const SizedBox(width: 12),
            Text(
              _formatPercentTr(changePercent),
              style: TextStyle(fontWeight: FontWeight.w700, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
