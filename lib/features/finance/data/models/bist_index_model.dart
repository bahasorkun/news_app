// lib/features/finance/data/models/bist_index_model.dart
class BistIndexModel {
  final double current; // anlık endeks puanı
  final double changeRate; // günlük % değişim (ör: -0.03)
  final double min;
  final double max;
  final double opening;
  final double closing;
  final String? time; // "13:35"
  final String? date; // "2019-12-09"
  final DateTime? dateTime; // "2019-12-09T10:35:00.000Z"

  const BistIndexModel({
    required this.current,
    required this.changeRate,
    required this.min,
    required this.max,
    required this.opening,
    required this.closing,
    this.time,
    this.date,
    this.dateTime,
  });

  // Virgül/nokta farklı gelebilir; esnek çeviri
  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();

    final raw = v.toString().trim();

    // 1) Direkt parse dene
    final p1 = double.tryParse(raw);
    if (p1 != null) return p1;

    // 2) Virgülü ondalık ayıracı say (TR formatı)
    final p2 = double.tryParse(raw.replaceAll(',', '.'));
    if (p2 != null) return p2;

    // 3) Binlik ayıracı temizle (., boşluk) sonra virgülü noktaya çevir
    final cleaned = raw.replaceAll(RegExp(r'[.\s]'), '').replaceAll(',', '.');
    return double.tryParse(cleaned) ?? 0.0;
  }

  factory BistIndexModel.fromMap(Map<String, dynamic> m) {
    return BistIndexModel(
      current: _toDouble(m['current'] ?? m['currentstr']),
      changeRate: _toDouble(m['changerate'] ?? m['changeratestr']),
      min: _toDouble(m['min'] ?? m['minstr']),
      max: _toDouble(m['max'] ?? m['maxstr']),
      opening: _toDouble(m['opening'] ?? m['openingstr']),
      closing: _toDouble(m['closing'] ?? m['closingstr']),
      time: m['time']?.toString(),
      date: m['date']?.toString(),
      dateTime: m['datetime'] != null
          ? DateTime.tryParse(m['datetime'].toString())
          : null,
    );
  }
}
