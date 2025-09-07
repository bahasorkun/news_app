class GoalKingItem {
  final int play;
  final int goals;
  final String name;

  GoalKingItem({required this.play, required this.goals, required this.name});

  factory GoalKingItem.fromJson(Map<String, dynamic> json) => GoalKingItem(
        play: int.tryParse((json['play'] ?? '0').toString()) ?? 0,
        goals: int.tryParse((json['goals'] ?? '0').toString()) ?? 0,
        name: (json['name'] ?? '').toString(),
      );
}

