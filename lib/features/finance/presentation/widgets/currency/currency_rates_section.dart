import 'package:flutter/material.dart';
import 'package:news_app/features/finance/data/finance_api.dart';
import 'package:news_app/features/finance/data/models/currency_model.dart';
import 'package:news_app/features/finance/presentation/widgets/currency/currency_rate_tile.dart';

class CurrencyRatesSection extends StatefulWidget {
  const CurrencyRatesSection({super.key});

  @override
  State<CurrencyRatesSection> createState() => _CurrencyRatesSectionState();
}

class _CurrencyRatesSectionState extends State<CurrencyRatesSection> {
  final _api = FinanceApi();
  late Future<List<CurrencyModel>> _future;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _future = _api.getCurrencies();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Döviz Kurları',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        FutureBuilder<List<CurrencyModel>>(
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
                  const Expanded(child: Text('Döviz verisi alınamadı')),
                  TextButton.icon(
                    onPressed: () =>
                        setState(() => _future = _api.getCurrencies()),
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tekrar Dene'),
                  ),
                ],
              );
            }

            final list = snap.data ?? const <CurrencyModel>[];
            if (list.isEmpty) return const SizedBox.shrink();

            final visible = _expanded ? list : list.take(3).toList();

            return Column(
              children: [
                ...visible.map((e) => CurrencyRateTile(item: e)),
                const SizedBox(height: 8),
                if (list.length > 3)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => setState(() => _expanded = !_expanded),
                      child: Text(
                        _expanded ? 'Daha Az Göster <<' : 'Tümünü Göster >>',
                        style: const TextStyle(fontWeight: FontWeight.w700),
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
