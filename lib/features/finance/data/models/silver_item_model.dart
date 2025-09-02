class SilverItemModel {
  final String currency; // Örn: "TRY"
  final double buying; // 3.0943
  final double selling; // 3.1005
  final String? updateTime; // "13:49" (opsiyonel)

  const SilverItemModel({
    required this.currency,
    required this.buying,
    required this.selling,
    this.updateTime,
  });

  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    final s = v.toString();
    return double.tryParse(s) ?? double.tryParse(s.replaceAll(',', '.')) ?? 0.0;
  }

  factory SilverItemModel.fromMap(Map<String, dynamic> m) {
    return SilverItemModel(
      currency: m['currency']?.toString() ?? '',
      buying: _toDouble(m['buying'] ?? m['buyingstr']),
      selling: _toDouble(m['selling'] ?? m['sellingstr']),
      updateTime: (m['updatetime'] ?? m['update_time'])?.toString(),
    );
  }

  Map<String, dynamic> toMap() => {
    'currency': currency,
    'buying': buying,
    'selling': selling,
    if (updateTime != null) 'updatetime': updateTime,
  };

  SilverItemModel copyWith({
    String? currency,
    double? buying,
    double? selling,
    String? updateTime,
  }) {
    return SilverItemModel(
      currency: currency ?? this.currency,
      buying: buying ?? this.buying,
      selling: selling ?? this.selling,
      updateTime: updateTime ?? this.updateTime,
    );
  }

  @override
  String toString() =>
      'SilverItemModel(currency: $currency, buying: $buying, selling: $selling, updateTime: ${updateTime ?? ''})';
}
