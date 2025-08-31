import 'package:flutter/material.dart';
import 'package:news_app/features/pharmacy/presentation/pages/pharmacy_result.dart';
import 'package:news_app/features/pharmacy/presentation/utils/input_decoration.dart';
import 'package:news_app/features/pharmacy/presentation/widgets/labeled_card.dart';
import 'package:news_app/features/pharmacy/data/pharmacy_api.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({super.key});

  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  String? _selectedCity;
  String? _selectedDistrict;

  final _api = PharmacyApi();

  // 81 il – sabit liste (alfabetik)
  final List<String> _cities = const [
    'Adana',
    'Adıyaman',
    'Afyonkarahisar',
    'Ağrı',
    'Aksaray',
    'Amasya',
    'Ankara',
    'Antalya',
    'Ardahan',
    'Artvin',
    'Aydın',
    'Balıkesir',
    'Bartın',
    'Batman',
    'Bayburt',
    'Bilecik',
    'Bingöl',
    'Bitlis',
    'Bolu',
    'Burdur',
    'Bursa',
    'Çanakkale',
    'Çankırı',
    'Çorum',
    'Denizli',
    'Diyarbakır',
    'Düzce',
    'Edirne',
    'Elazığ',
    'Erzincan',
    'Erzurum',
    'Eskişehir',
    'Gaziantep',
    'Giresun',
    'Gümüşhane',
    'Hakkari',
    'Hatay',
    'Iğdır',
    'Isparta',
    'İstanbul',
    'İzmir',
    'Kahramanmaraş',
    'Karabük',
    'Karaman',
    'Kars',
    'Kastamonu',
    'Kayseri',
    'Kırıkkale',
    'Kırklareli',
    'Kırşehir',
    'Kilis',
    'Kocaeli',
    'Konya',
    'Kütahya',
    'Malatya',
    'Manisa',
    'Mardin',
    'Mersin',
    'Muğla',
    'Muş',
    'Nevşehir',
    'Niğde',
    'Ordu',
    'Osmaniye',
    'Rize',
    'Sakarya',
    'Samsun',
    'Siirt',
    'Sinop',
    'Sivas',
    'Şanlıurfa',
    'Şırnak',
    'Tekirdağ',
    'Tokat',
    'Trabzon',
    'Tunceli',
    'Uşak',
    'Van',
    'Yalova',
    'Yozgat',
    'Zonguldak',
  ];

  // API'den yüklenecek (CollectAPI bazen {text, pharmacy_number} map döndürüyor)
  List<dynamic> _districts = [];
  bool _loadingDistricts = false;

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
      MaterialPageRoute(
        builder: (context) => PharmacyResultPage(
          city: _selectedCity!,
          district: _selectedDistrict!,
        ),
      ),
    );
  }

  void _showSnack(String msg) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  Future<void> _loadDistricts(String city) async {
    setState(() {
      _loadingDistricts = true;
      _districts = [];
      _selectedDistrict = null;
    });
    try {
      final list = await _api.getDistricts(city);
      setState(() {
        _districts = list;
        _loadingDistricts = false;
      });
    } catch (e) {
      setState(() => _loadingDistricts = false);
      _showSnack('İlçeler yüklenemedi: $e');
    }
  }

  String _extractDistrictText(dynamic e) {
    if (e is Map) {
      final t = e['text'];
      if (t != null) return t.toString();
      if (e.values.isNotEmpty) return e.values.first.toString();
      return '';
    }
    final s = e?.toString() ?? '';
    // Try to pull "text: XYZ" from a string like "{text: XYZ, pharmacy_number: 3}"
    final m = RegExp(r'text\s*:\s*([^,}]+)').firstMatch(s);
    if (m != null) return m.group(1)!.trim();
    return s;
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
                    isExpanded: true,
                    items: _cities
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (v) {
                      setState(() => _selectedCity = v);
                      if (v != null && v.isNotEmpty) {
                        _loadDistricts(v);
                      } else {
                        setState(() {
                          _selectedDistrict = null;
                          _districts = [];
                        });
                      }
                    },
                  ),
                ),

                const SizedBox(height: 16),

                // İlçe kartı (dinamik)
                LabeledCard(
                  label: 'İlçe Seçimi',
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_loadingDistricts) const LinearProgressIndicator(),
                      DropdownButtonFormField<String>(
                        decoration: inputDecoration(
                          _selectedCity == null
                              ? 'Önce il seçin'
                              : 'Bir ilçe seçin',
                        ),
                        icon: const Icon(Icons.keyboard_arrow_down_rounded),
                        value: _selectedDistrict,
                        isExpanded: true,
                        items: _districts.map((e) {
                          final text = _extractDistrictText(e);
                          return DropdownMenuItem<String>(
                            value: text,
                            child: Text(
                              text,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          );
                        }).toList(),
                        onChanged: (_selectedCity == null || _loadingDistricts)
                            ? null
                            : (v) => setState(() => _selectedDistrict = v),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Sorgula butonu
                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed:
                        (_selectedCity != null && _selectedDistrict != null)
                        ? _queryPharmacies
                        : null,
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
