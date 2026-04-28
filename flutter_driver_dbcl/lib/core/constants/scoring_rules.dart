import 'package:flutter/material.dart';

class ScoringRules {
  static const int initialScore = 1000;
  static const int maxScore = 1000;
  static const int minScore = 50;

  static const int hardBrakePenalty = -5;
  static const int fatiguePenalty = -2;
  static const int drowsyPenalty = -3;
  static const int alcoholPenalty = -8;
  static const int distractionPenalty = -2;
  static const int faceFailPenalty = -3;

  static const int hardBrakeCooldownMs = 15000;
  static const int fatigueCooldownMs = 30000;
  static const int drowsyCooldownMs = 60000;
  static const int distractionCooldownMs = 45000;
  static const int faceFailCooldownMs = 120000;
  static const int maxHardBrakesPerTrip = 3;

  static const int recovery10Min = 1;
  static const int recovery30Min = 3;
  static const int recoveryGoodTrip = 2;
  static const int recovery7DayStreak = 10;

  static const double earThreshold = 0.20;
  static const int fatigueTimeMs = 1500;
  static const int drowsyTimeMs = 3000;
  static const double hardBrakeGForce = 3.0;

  static ScoreBand getBand(int score) {
    if (score >= 900) return ScoreBand.elite;
    if (score >= 750) return ScoreBand.safe;
    if (score >= 600) return ScoreBand.average;
    if (score >= 400) return ScoreBand.atRisk;
    return ScoreBand.dangerous;
  }
}

enum ScoreBand {
  elite("Elite Driver", "🟢", Color(0xFF00E87A)),
  safe("Safe Driver", "🔵", Color(0xFF00C8FF)),
  average("Average", "🟡", Color(0xFFFFB800)),
  atRisk("At Risk", "🟠", Color(0xFFFF7A30)),
  dangerous("Dangerous", "🔴", Color(0xFFFF4560));

  final String label;
  final String emoji;
  final Color color;

  const ScoreBand(this.label, this.emoji, this.color);
}
