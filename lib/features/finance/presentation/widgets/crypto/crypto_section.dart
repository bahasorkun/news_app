import 'package:flutter/material.dart';
import 'package:news_app/features/finance/data/finance_api.dart';
import 'package:news_app/features/finance/data/models/crypto_model.dart';
import 'package:news_app/features/finance/presentation/widgets/crypto/crypto_card.dart';

class CryptoSection extends StatefulWidget {
  const CryptoSection({super.key});

  @override
  State<CryptoSection> createState() => _CryptoSectionState();
}

class _CryptoSectionState extends State<CryptoSection> {
  final _api = FinanceApi();
  late Future<List<CryptoModel>> _future;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _future = _api.getCryptoTickers();
  }

  List<CryptoModel> _pickTopThree(List<CryptoModel> list) {
    if (list.isEmpty) return const [];

    CryptoModel? find(String symbol) {
      try {
        return list.firstWhere(
          (e) => e.symbol.toUpperCase() == symbol.toUpperCase(),
        );
      } catch (_) {
        return null;
      }
    }

    final ordered = <CryptoModel>[];
    for (final s in ['BTC', 'ETH', 'USDT']) {
      final f = find(s);
      if (f != null) ordered.add(f);
    }

    if (ordered.length < 3) {
      for (final e in list) {
        if (ordered.length >= 3) break;
        if (!ordered.contains(e)) ordered.add(e);
      }
    }

    return ordered.take(3).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kripto Paralar',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        FutureBuilder<List<CryptoModel>>(
          future: _future,
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 24),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (snap.hasError) {
              return Row(
                children: [
                  const Icon(Icons.error_outline, color: Colors.red),
                  const SizedBox(width: 8),
                  const Expanded(child: Text('Kripto verileri alınamadı')),
                  TextButton.icon(
                    onPressed: () {
                      // setState callback must be synchronous and return void.
                      // Use a block body to avoid returning the Future from the assignment.
                      setState(() {
                        _future = _api.getCryptoTickers();
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tekrar Dene'),
                  ),
                ],
              );
            }

            final original = snap.data ?? const <CryptoModel>[];
            if (original.isEmpty) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text('Gösterilecek kripto bulunamadı'),
              );
            }

            // When collapsed, show curated top 3; when expanded, show all
            final topThree = _pickTopThree(original);
            final visible = _expanded
                ? [...topThree, ...original.where((e) => !topThree.contains(e))]
                : topThree;

            return Column(
              children: [
                for (final c in visible)
                  CryptoCard(
                    name: c.name.isNotEmpty ? c.name : c.symbol,
                    symbol: c.symbol,
                    priceUsd: c.priceUsd,
                    changePercent: c.changePercent24h,
                  ),
                if (original.length > 3)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => setState(() => _expanded = !_expanded),
                      child: Text(
                        _expanded ? 'Daha Az Göster <<' : 'Tümünü Göster >>',
                        style: const TextStyle(
                          color: Colors.indigo,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ],
    );
  }
}
