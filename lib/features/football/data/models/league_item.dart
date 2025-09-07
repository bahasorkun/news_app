class LeagueItem {
  final String league;
  final String key;

  LeagueItem({required this.league, required this.key});

  factory LeagueItem.fromJson(Map<String, dynamic> json) {
    return LeagueItem(
      league: (json['league'] ?? '').toString(),
      key: (json['key'] ?? '').toString(),
    );
  }
}

