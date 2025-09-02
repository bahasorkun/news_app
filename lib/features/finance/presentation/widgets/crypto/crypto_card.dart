import 'package:flutter/material.dart';

class CryptoCard extends StatelessWidget {
  final String name; // e.g., Bitcoin (BTC)
  final String symbol; // e.g., BTC
  final double priceUsd; // e.g., 110425.14
  final double changePercent; // e.g., 2.25 or -0.12

  const CryptoCard({
    super.key,
    required this.name,
    required this.symbol,
    required this.priceUsd,
    required this.changePercent,
  });

  String _formatUsd(double v) {
    // Simple thousands grouping from right to left, no extra deps
    final fixed = v.toStringAsFixed(2);
    final parts = fixed.split('.');
    final raw = parts[0];
    final dec = parts[1];
    final chars = raw.split('').reversed.toList();
    final out = <String>[];
    for (int i = 0; i < chars.length; i++) {
      if (i != 0 && i % 3 == 0) out.add(',');
      out.add(chars[i]);
    }
    final withSep = out.reversed.join();
    return '$withSep.$dec';
  }

  @override
  Widget build(BuildContext context) {
    final positive = changePercent >= 0;
    final color = positive ? Colors.green : Colors.red;
    final title = symbol.isNotEmpty ? '$name ($symbol)' : name;

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
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  _formatUsd(priceUsd),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const Text('USD', style: TextStyle(color: Colors.grey)),
              ],
            ),
            const SizedBox(width: 12),
            Text(
              '${changePercent.toStringAsFixed(2)}%',
              style: TextStyle(fontWeight: FontWeight.w600, color: color),
            ),
          ],
        ),
      ),
    );
  }
}
