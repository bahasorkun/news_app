import 'package:flutter/material.dart';
import 'package:news_app/features/finance/data/finance_api.dart';
import 'package:news_app/features/finance/data/models/gold_item_model.dart';
import 'package:news_app/features/finance/data/models/silver_item_model.dart';
import 'package:news_app/features/finance/presentation/widgets/precious_metals/precious_metals_card.dart';

class PreciousMetalsSection extends StatefulWidget {
  const PreciousMetalsSection({super.key});

  @override
  State<PreciousMetalsSection> createState() => _PreciousMetalsSectionState();
}

class _PreciousMetalsSectionState extends State<PreciousMetalsSection> {
  final _api = FinanceApi();
  late Future<(_GoldPair, SilverItemModel)> _future;

  @override
  void initState() {
    super.initState();
    _future = _load();
  }

  Future<(_GoldPair, SilverItemModel)> _load() async {
    // Altınları ve gümüşü paralel çek
    final goldFuture = _api.getGoldPrices();
    final silverFuture = _api.getSilverPrice();

    final results = await Future.wait([goldFuture, silverFuture]);
    final goldList = results[0] as List<GoldItemModel>;
    final silver = results[1] as SilverItemModel;

    GoldItemModel? gram;
    GoldItemModel? ons;

    for (final g in goldList) {
      final n = g.name.toLowerCase();
      if (gram == null && (n.contains('gram') || n.contains('gr.'))) {
        gram = g;
      }
      if (ons == null && (n.contains('ons') || n.contains('ounce'))) {
        ons = g;
      }
      if (gram != null && ons != null) break;
    }

    // Emniyet: bulunamazsa listeden ilk iki kalemi kullan (boş ekran yerine)
    gram ??= goldList.isNotEmpty
        ? goldList.first
        : GoldItemModel(name: 'Gram Altın', buy: 0, sell: 0);
    ons ??= goldList.length > 1
        ? goldList[1]
        : GoldItemModel(name: 'ONS Altın', buy: 0, sell: 0);

    return (_GoldPair(gram: gram, ons: ons), silver);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Kıymetli Madenler',
          style: Theme.of(
            context,
          ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        FutureBuilder<(_GoldPair, SilverItemModel)>(
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
                  const Expanded(
                    child: Text('Kıymetli maden verileri alınamadı'),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _future = _load();
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Tekrar Dene'),
                  ),
                ],
              );
            }

            final data = snap.data!;
            final pair = data.$1; // _GoldPair
            final silver = data.$2; // SilverItemModel

            return Column(
              children: [
                PreciousMetalsCard(
                  title: 'Gram Altın',
                  buy: pair.gram.buy,
                  sell: pair.gram.sell,
                ),
                PreciousMetalsCard(
                  title: 'ONS Altın',
                  buy: pair.ons.buy,
                  sell: pair.ons.sell,
                ),
                PreciousMetalsCard(
                  title: 'Gümüş',
                  buy: silver.buying,
                  sell: silver.selling,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

class _GoldPair {
  final GoldItemModel gram;
  final GoldItemModel ons;
  const _GoldPair({required this.gram, required this.ons});
}
