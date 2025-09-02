class GoldItemModel {
  final String name; // Örn: "Gram Altın", "ONS"
  final double buy; // Alış
  final double
  sell; // Satış (bazı kayıtlarda '-' gelebilir -> 0.0'a çevrilecek)

  const GoldItemModel({
    required this.name,
    required this.buy,
    required this.sell,
  });

  /// String/num -> double güvenli dönüşüm
  static double _toDouble(dynamic v) {
    if (v == null || v == '-') return 0.0;
    if (v is num) return v.toDouble();
    final s = v.toString();
    return double.tryParse(s) ?? double.tryParse(s.replaceAll(',', '.')) ?? 0.0;
  }

  factory GoldItemModel.fromMap(Map<String, dynamic> m) {
    return GoldItemModel(
      name: m['name']?.toString() ?? '',
      buy: _toDouble(m['buy'] ?? m['buying']),
      sell: _toDouble(m['sell'] ?? m['selling']),
    );
  }

  Map<String, dynamic> toMap() => {'name': name, 'buy': buy, 'sell': sell};

  GoldItemModel copyWith({String? name, double? buy, double? sell}) {
    return GoldItemModel(
      name: name ?? this.name,
      buy: buy ?? this.buy,
      sell: sell ?? this.sell,
    );
  }

  @override
  String toString() => 'GoldItemModel(name: $name, buy: $buy, sell: $sell)';
}
