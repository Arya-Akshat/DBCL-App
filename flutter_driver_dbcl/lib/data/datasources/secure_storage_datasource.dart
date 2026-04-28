import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageDataSource {
  static const _storage = FlutterSecureStorage();
  static const _keyPrefix = 'driver_embedding_';

  Future<void> saveEmbedding(String driverId, List<double> embedding) async {
    await _storage.write(
      key: '$_keyPrefix$driverId',
      value: jsonEncode(embedding),
    );
  }

  Future<List<double>?> getEmbedding(String driverId) async {
    final value = await _storage.read(key: '$_keyPrefix$driverId');
    if (value == null) return null;
    return (jsonDecode(value) as List).cast<double>();
  }
}
