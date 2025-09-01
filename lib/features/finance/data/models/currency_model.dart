class CurrencyModel {
  final String name; // USD Amerikan Doları
  final double buying; // alış
  final double selling; // satış

  CurrencyModel({
    required this.name,
    required this.buying,
    required this.selling,
  });

  /// Yardımcı: string -> double dönüşümü
  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    final s = v.toString();
    return double.tryParse(s.replaceAll(',', '.')) ?? 0.0;
  }

  factory CurrencyModel.fromMap(Map<String, dynamic> map) {
    return CurrencyModel(
      name: map['name']?.toString() ?? '',
      buying: _toDouble(map['buying']),
      selling: _toDouble(map['selling']),
    );
  }

  Map<String, dynamic> toMap() {
    return {'name': name, 'buying': buying, 'selling': selling};
  }

  @override
  String toString() =>
      'CurrencyModel(name: $name, buying: $buying, selling: $selling)';
}
