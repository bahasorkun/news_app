import 'package:flutter/material.dart';
import 'package:news_app/features/finance/presentation/widgets/bistIndex/bist_index_section.dart';
import 'package:news_app/features/finance/presentation/widgets/currency/currency_rates_section.dart';

class FinancePage extends StatefulWidget {
  const FinancePage({super.key});

  @override
  State<FinancePage> createState() => _FinancePageState();
}

class _FinancePageState extends State<FinancePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 72,
        title: Text(
          "Finans Piyasaları",
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: ListView(
        padding: EdgeInsets.fromLTRB(16, 20, 16, 24),
        children: [
          const BistIndexSection(),
          const SizedBox(height: 16),
          const CurrencyRatesSection(),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
