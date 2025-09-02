class EmtiaItemModel {
  final String name; // e.g., "Brent Petrol" or localized text
  final double selling; // e.g., 63.87 (USD)
  final double rate; // daily change percent (e.g., -0.64)

  const EmtiaItemModel({
    required this.name,
    required this.selling,
    required this.rate,
  });

  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    final s = v.toString().trim();
    final cleaned = s.replaceAll('%', '').replaceAll(' ', '').replaceAll(',', '.');
    return double.tryParse(cleaned) ?? 0.0;
  }

  factory EmtiaItemModel.fromMap(Map<String, dynamic> m) {
    return EmtiaItemModel(
      name: (m['text'] ?? m['name'] ?? '').toString(),
      selling: _toDouble(m['selling'] ?? m['sellingstr'] ?? m['price']),
      rate: _toDouble(m['rate']),
    );
  }

  Map<String, dynamic> toMap() => {
        'name': name,
        'selling': selling,
        'rate': rate,
      };
}

