class ScoreSummary {
  const ScoreSummary({
    required this.score,
    required this.ranking,
  });

  final int score;
  final String ranking;

  factory ScoreSummary.fromJson(Map<String, dynamic> json) {
    return ScoreSummary(
      score: json['score'] as int? ?? 82,
      ranking: json['ranking'] as String? ?? 'Professional',
    );
  }
}
