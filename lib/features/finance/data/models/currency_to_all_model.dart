class CurrencyToAllItem {
  final String code; // e.g., USD
  final String name; // e.g., US Dollar
  final double rate; // relative to base
  final double calculated; // amount converted

  const CurrencyToAllItem({
    required this.code,
    required this.name,
    required this.rate,
    required this.calculated,
  });

  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    final s = v.toString().trim().replaceAll(',', '.');
    return double.tryParse(s) ?? 0.0;
  }

  factory CurrencyToAllItem.fromMap(Map<String, dynamic> m) => CurrencyToAllItem(
        code: (m['code'] ?? '').toString(),
        name: (m['name'] ?? '').toString(),
        rate: _toDouble(m['rate']),
        calculated: _toDouble(m['calculated'] ?? m['calculatedstr']),
      );
}

class CurrencyToAllResponse {
  final String base; // e.g., USD
  final String lastUpdate;
  final List<CurrencyToAllItem> items;

  const CurrencyToAllResponse({
    required this.base,
    required this.lastUpdate,
    required this.items,
  });

  factory CurrencyToAllResponse.fromMap(Map<String, dynamic> m) {
    final result = m['result'];
    if (result is Map<String, dynamic>) {
      final list = (result['data'] is List) ? (result['data'] as List) : const [];
      return CurrencyToAllResponse(
        base: (result['base'] ?? '').toString(),
        lastUpdate: (result['lastupdate'] ?? '').toString(),
        items: list
            .whereType<Map>()
            .map((e) => CurrencyToAllItem.fromMap(Map<String, dynamic>.from(e)))
            .toList(),
      );
    }
    // Fallback if structure is different
    final list = (m['data'] is List) ? (m['data'] as List) : const [];
    return CurrencyToAllResponse(
      base: (m['base'] ?? '').toString(),
      lastUpdate: (m['lastupdate'] ?? '').toString(),
      items: list
          .whereType<Map>()
          .map((e) => CurrencyToAllItem.fromMap(Map<String, dynamic>.from(e)))
          .toList(),
    );
  }
}

