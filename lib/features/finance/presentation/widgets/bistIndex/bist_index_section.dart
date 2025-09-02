import 'package:flutter/material.dart';
import 'package:news_app/features/finance/data/finance_api.dart';
import 'package:news_app/features/finance/data/models/bist_index_model.dart';
import 'package:news_app/features/finance/presentation/widgets/bistIndex/bist_index_card.dart';

class BistIndexSection extends StatefulWidget {
  const BistIndexSection({super.key});

  @override
  State<BistIndexSection> createState() => _BistIndexSectionState();
}

class _BistIndexSectionState extends State<BistIndexSection> {
  final _api = FinanceApi();
  late Future<BistIndexModel> _future;

  @override
  void initState() {
    super.initState();
    _future = _api.getBistIndex();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<BistIndexModel>(
      future: _future,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const SizedBox(
            height: 140,
            child: Center(child: CircularProgressIndicator()),
          );
        }
        if (snap.hasError) {
          return _ErrorRetry(
            message: 'BIST verisi alınamadı',
            onRetry: () => setState(() {
              _future = _api.getBistIndex();
            }),
          );
        }
        final data = snap.data!;
        return BistIndexCard(data: data);
      },
    );
  }
}

class _ErrorRetry extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;
  const _ErrorRetry({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(message),
            const SizedBox(height: 8),
            TextButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Tekrar Dene'),
            ),
          ],
        ),
      ),
    );
  }
}
