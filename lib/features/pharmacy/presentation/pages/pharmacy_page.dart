import 'package:flutter/material.dart';
import 'package:news_app/features/pharmacy/data/pharmacy_api.dart';
import 'package:news_app/features/pharmacy/presentation/pages/pharmacy_result.dart';
import 'package:news_app/features/pharmacy/presentation/utils/input_decoration.dart';
import 'package:news_app/features/pharmacy/presentation/widgets/labeled_card.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({super.key});

  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  final _api = PharmacyApi();

  // --- UI State ---
  String? _selectedCity;
  String? _selectedDistrict;

  // İlleri sade ve anlaşılır tutalım (örnek liste)
  final List<String> _cities = const [
    'Ankara',
    'İstanbul',
    'İzmir',
    'Adana',
    'Antalya',
    'Bursa',
  ];

  // Basit örnek ilçe listeleri (gerçekte API ile dolduracağız)
  final Map<String, List<String>> _districtsByCity = const {
    'Ankara': ['Çankaya', 'Keçiören', 'Yenimahalle', 'Mamak', 'Sincan'],
    'İstanbul': ['Beşiktaş', 'Kadıköy', 'Üsküdar', 'Şişli', 'Fatih'],
    'İzmir': ['Konak', 'Karşıyaka', 'Bornova', 'Buca'],
    'Adana': ['Seyhan', 'Yüreğir', 'Çukurova'],
    'Antalya': ['Muratpaşa', 'Kepez', 'Konyaaltı'],
    'Bursa': ['Osmangazi', 'Nilüfer', 'Yıldırım'],
  };

  List<String> get _districts => _selectedCity == null
      ? const []
      : (_districtsByCity[_selectedCity] ?? []);

  Future<void> _queryPharmacies() async {
    if (_selectedCity == null || _selectedCity!.isEmpty) {
      _showSnack('Lütfen bir il seçin.');
      return;
    }
    if (_selectedDistrict == null || _selectedDistrict!.isEmpty) {
      _showSnack('Lütfen bir ilçe seçin.');
      return;
    }

    if (!mounted) return;
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => PharmacyResultPage()),
    );
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        // Arka plan
        Container(color: const Color(0xFFFAF8F4)),

        SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Nöbetçi Eczaneler',
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 24),

                // İl kartı
                LabeledCard(
                  label: 'İl Seçimi *',
                  child: DropdownButtonFormField<String>(
                    decoration: inputDecoration('Bir il seçin'),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    value: _selectedCity,
                    items: _cities
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) {
                      setState(() {
                        _selectedCity = v;
                        _selectedDistrict = null; // il değişince sıfırla
                      });
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // İlçe kartı
                LabeledCard(
                  label: 'İlçe Seçimi',
                  child: DropdownButtonFormField<String>(
                    decoration: inputDecoration('Bir ilçe seçin'),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded),
                    value: _selectedDistrict,
                    items: _districts
                        .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                        .toList(),
                    onChanged: (v) => setState(() => _selectedDistrict = v),
                  ),
                ),

                const SizedBox(height: 24),

                // Sorgula butonu
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: _queryPharmacies,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo.shade400,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'SORGULA',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
