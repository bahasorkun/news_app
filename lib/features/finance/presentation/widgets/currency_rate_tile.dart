import 'package:flutter/material.dart';
import 'package:news_app/features/finance/data/models/currency_model.dart';

class CurrencyRateTile extends StatelessWidget {
  final CurrencyModel item;
  const CurrencyRateTile({super.key, required this.item});

  String _fmt(double v) => v.toStringAsFixed(4);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Expanded(
              child: Text(
                item.name,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Alış: ${_fmt(item.buying)}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.black45),
                ),
                const SizedBox(height: 4),
                Text(
                  'Satış: ${_fmt(item.selling)}',
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.black45),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
