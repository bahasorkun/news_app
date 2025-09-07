class StandingItem {
  final int rank;
  final int lose;
  final int win;
  final int play;
  final int point;
  final String team;

  StandingItem({
    required this.rank,
    required this.lose,
    required this.win,
    required this.play,
    required this.point,
    required this.team,
  });

  factory StandingItem.fromJson(Map<String, dynamic> json) => StandingItem(
    rank: int.tryParse((json['rank'] ?? '0').toString()) ?? 0,
    lose: int.tryParse((json['lose'] ?? '0').toString()) ?? 0,
    win: int.tryParse((json['win'] ?? '0').toString()) ?? 0,
    play: int.tryParse((json['play'] ?? '0').toString()) ?? 0,
    point: int.tryParse((json['point'] ?? '0').toString()) ?? 0,
    team: (json['team'] ?? '').toString(),
  );
}
