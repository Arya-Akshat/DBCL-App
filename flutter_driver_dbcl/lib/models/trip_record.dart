class TripRecord {
  const TripRecord({
    required this.id,
    required this.startTime,
    required this.endTime,
    required this.score,
    required this.eventsCount,
  });

  final String id;
  final DateTime startTime;
  final DateTime endTime;
  final int score;
  final int eventsCount;

  Duration get duration => endTime.difference(startTime);

  factory TripRecord.fromJson(Map<String, dynamic> json) {
    return TripRecord(
      id: json['id'] as String? ?? 'trip',
      startTime: DateTime.tryParse(json['start_time'] as String? ?? '') ??
          DateTime.now().subtract(const Duration(hours: 1)),
      endTime: DateTime.tryParse(json['end_time'] as String? ?? '') ?? DateTime.now(),
      score: json['score'] as int? ?? 80,
      eventsCount: json['events_count'] as int? ?? 0,
    );
  }
}
