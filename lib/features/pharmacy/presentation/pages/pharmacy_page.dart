import 'package:flutter/material.dart';
import 'package:news_app/features/pharmacy/data/pharmacy_api.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({super.key});

  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  final _api = PharmacyApi();
  Future<void> _testPharmacy() async {
    try {
      final list = await _api.getDutyPharmacies(
        city: "Ankara",
        district: "Çankaya",
      );
      print("Toplam Eczane : ${list.length}");
      if (list.isNotEmpty) {
        final p = list.first;
        print("İlk : ${p.name} * ${p.phone} * ${p.address}");
      }
    } catch (e) {
      print("Hata : $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _testPharmacy();
  }

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Pharmacy"));
  }
}
