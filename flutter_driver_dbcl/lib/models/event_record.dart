class EventRecord {
  const EventRecord({
    required this.id,
    required this.type,
    required this.duration,
    required this.timestamp,
    required this.points,
    this.imageUrl,
    this.isRecovery = false,
  });

  final String id;
  final String type;
  final double duration;
  final DateTime timestamp;
  final int points;
  final String? imageUrl;
  final bool isRecovery;

  bool get isPenalty => !isRecovery && points < 0;

  factory EventRecord.fromJson(Map<String, dynamic> json) {
    final rawTimestamp = json['timestamp'];
    final parsedTimestamp = rawTimestamp is int
        ? DateTime.fromMillisecondsSinceEpoch(rawTimestamp * 1000)
        : DateTime.tryParse(rawTimestamp?.toString() ?? '') ?? DateTime.now();

    return EventRecord(
      id: json['id'] as String? ?? '${json['type']}-${parsedTimestamp.millisecondsSinceEpoch}',
      type: json['type'] as String? ?? 'unknown',
      duration: (json['duration'] as num?)?.toDouble() ?? 0,
      timestamp: parsedTimestamp,
      points: json['points'] as int? ?? -5,
      imageUrl: json['image_url'] as String? ?? json['snapshot_path'] as String?,
      isRecovery: json['is_recovery'] as bool? ?? ((json['points'] as int? ?? 0) > 0),
    );
  }
}
