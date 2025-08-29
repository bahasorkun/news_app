import 'package:flutter/material.dart';
import 'package:news_app/features/pharmacy/data/models/pharmacy_model.dart';
import 'package:news_app/features/pharmacy/data/pharmacy_api.dart';

class PharmacyResultPage extends StatefulWidget {
  final String city;
  final String district;
  const PharmacyResultPage({
    super.key,
    required this.city,
    required this.district,
  });

  @override
  State<PharmacyResultPage> createState() => _PharmacyResultPageState();
}

class _PharmacyResultPageState extends State<PharmacyResultPage> {
  final _api = PharmacyApi();

  late Future<List<PharmacyModel>> _future;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
