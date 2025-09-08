import 'package:flutter/material.dart';
import 'package:news_app/features/finance/data/finance_api.dart';
import 'package:news_app/features/finance/data/models/emtia_item_model.dart';
import 'package:news_app/features/finance/presentation/widgets/emtia/emtia_card.dart';
import 'package:news_app/core/l10n/app_localizations.dart';

class EmtiaSection extends StatefulWidget {
  const EmtiaSection({super.key});

  @override
  State<EmtiaSection> createState() => _EmtiaSectionState();
}

class _EmtiaSectionState extends State<EmtiaSection> {
  final _api = FinanceApi();
  late Future<List<EmtiaItemModel>> _future;
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    _future = _api.getEmtiaItems();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).t('commodityMarket'),
          style: Theme.of(context)
              .textTheme
              .headlineSmall
              ?.copyWith(fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 8),
        FutureBuilder<List<EmtiaItemModel>>(
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
                  Expanded(child: Text(AppLocalizations.of(context).t('commodityError'))),
                  TextButton.icon(
                    onPressed: () {
                      setState(() {
                        _future = _api.getEmtiaItems();
                      });
                    },
                    icon: const Icon(Icons.refresh),
                    label: Text(AppLocalizations.of(context).t('retry')),
                  ),
                ],
              );
            }

            final list = snap.data ?? const <EmtiaItemModel>[];
            if (list.isEmpty) {
              return Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Text(AppLocalizations.of(context).t('noCommodities')),
              );
            }

            final visible = _expanded ? list : list.take(3).toList();

            return Column(
              children: [
                for (final e in visible)
                  EmtiaCard(
                    name: e.name,
                    sellingUsd: e.selling,
                    changePercent: e.rate,
                  ),
                if (list.length > 3)
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => setState(() => _expanded = !_expanded),
                      child: Text(
                        _expanded
                            ? AppLocalizations.of(context).t('showLess')
                            : AppLocalizations.of(context).t('showAll'),
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          color: Colors.indigo,
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
