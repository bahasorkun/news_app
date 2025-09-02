class CryptoModel {
  final String name; // e.g., Bitcoin
  final String symbol; // e.g., BTC
  final double priceUsd; // spot price in USD
  final double changePercent24h; // daily change percent (e.g., 2.25 for +2.25%)

  const CryptoModel({
    required this.name,
    required this.symbol,
    required this.priceUsd,
    required this.changePercent24h,
  });

  static double _toDouble(dynamic v) {
    if (v == null) return 0.0;
    if (v is num) return v.toDouble();
    final s = v.toString().trim();
    // Remove percentage sign and spaces, normalize comma decimal
    final cleaned = s
        .replaceAll('%', '')
        .replaceAll(' ', '')
        .replaceAll(',', '.');
    return double.tryParse(cleaned) ?? 0.0;
  }

  factory CryptoModel.fromMap(Map<String, dynamic> m) {
    // Try multiple common key variants to be resilient to API shapes
    final name = (m['name'] ?? m['coin'] ?? m['title'] ?? '').toString();
    final symbol = (m['symbol'] ?? m['code'] ?? m['ticker'] ?? '').toString();
    final price = _toDouble(
      m['price_usd'] ?? m['priceUsd'] ?? m['price'] ?? m['usd'],
    );
    final change = _toDouble(
      // Primary for this API: daily change percent
      m['changeDay'] ??
          m['changeDaystr'] ??
          // Common alternates
          m['changePercent24h'] ??
          m['change_percent_24h'] ??
          m['change_rate'] ??
          m['changerate'] ??
          m['change24h'] ??
          m['daily_change'] ??
          m['percent'],
    );

    return CryptoModel(
      name: name,
      symbol: symbol,
      priceUsd: price,
      changePercent24h: change,
    );
  }

  Map<String, dynamic> toMap() => {
    'name': name,
    'symbol': symbol,
    'price_usd': priceUsd,
    'change_percent_24h': changePercent24h,
  };
}
