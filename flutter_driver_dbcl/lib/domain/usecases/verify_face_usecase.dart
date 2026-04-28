import 'dart:math';
import '../../data/datasources/secure_storage_datasource.dart';

class VerifyFaceUseCase {
  final SecureStorageDataSource storage;

  VerifyFaceUseCase(this.storage);

  Future<bool> verify(String driverId, List<double> currentEmbedding) async {
    final storedEmbedding = await storage.getEmbedding(driverId);
    if (storedEmbedding == null) return true; // Auto-enroll if none stored

    // Euclidean distance
    double sum = 0;
    for (int i = 0; i < currentEmbedding.length; i++) {
      final diff = currentEmbedding[i] - storedEmbedding[i];
      sum += diff * diff;
    }
    final distance = sqrt(sum);

    return distance < 0.9; // Threshold from Kotlin code
  }

  Future<void> enroll(String driverId, List<double> embedding) async {
    await storage.saveEmbedding(driverId, embedding);
  }
}
