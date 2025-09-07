class ResultItem {
  final String score;
  final String date;
  final String away;
  final String home;

  ResultItem({
    required this.score,
    required this.date,
    required this.away,
    required this.home,
  });

  factory ResultItem.fromJson(Map<String, dynamic> json) => ResultItem(
        score: (json['score'] ?? '').toString(),
        date: (json['date'] ?? '').toString(),
        away: (json['away'] ?? '').toString(),
        home: (json['home'] ?? '').toString(),
      );
}

