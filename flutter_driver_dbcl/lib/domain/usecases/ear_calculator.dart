import 'dart:math';
import '../entities/landmark.dart';
import '../../core/constants/scoring_rules.dart';

class EarCalculator {
  // Landmark indices for eyes
  static const List<int> leftEyeIdx = [33, 160, 158, 133, 153, 144];
  static const List<int> rightEyeIdx = [362, 385, 387, 263, 373, 380];

  // Phone ear landmarks
  static const int leftEarLm = 234;
  static const int rightEarLm = 454;

  /// Calculates average EAR for both eyes
  static double calculate(List<Landmark> landmarks) {
    if (landmarks.length < 468) return 1.0; // Eyes open if no face detected
    
    final leftEar = _eyeRatio(landmarks, leftEyeIdx);
    final rightEar = _eyeRatio(landmarks, rightEyeIdx);
    
    return (leftEar + rightEar) / 2.0;
  }

  static double _eyeRatio(List<Landmark> lm, List<int> idx) {
    final pts = idx.map((i) => Point(lm[i].x, lm[i].y)).toList();

    // Vertical distances
    final v1 = _dist(pts[1], pts[5]);
    final v2 = _dist(pts[2], pts[4]);

    // Horizontal distance
    final h = _dist(pts[0], pts[3]);

    if (h < 0.001) return 1.0;
    return (v1 + v2) / (2.0 * h);
  }

  static double _dist(Point<double> a, Point<double> b) {
    final dx = a.x - b.x;
    final dy = a.y - b.y;
    return sqrt(dx * dx + dy * dy);
  }

  static bool isEyesClosed(double ear) => ear < ScoringRules.earThreshold;

  static bool isHandNearEar(List<Landmark> handLms, List<Landmark> faceLms) {
    if (faceLms.length < 468 || handLms.isEmpty) return false;
    
    final leftEar = faceLms[leftEarLm];
    final rightEar = faceLms[rightEarLm];
    final finger = handLms[8]; // Index fingertip

    final distLeft = _dist(Point(finger.x, finger.y), Point(leftEar.x, leftEar.y));
    final distRight = _dist(Point(finger.x, finger.y), Point(rightEar.x, rightEar.y));

    return distLeft < 0.15 || distRight < 0.15;
  }
}
