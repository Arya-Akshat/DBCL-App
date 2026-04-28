import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/app_state.dart';
import '../models/auth_session.dart';

class SessionStorageService {
  SessionStorageService([FlutterSecureStorage? storage])
      : _storage = storage ?? const FlutterSecureStorage();

  static const _sessionKey = 'dbcl_session';
  static const _themeKey = 'dbcl_theme';
  static const _biometricKey = 'dbcl_biometric';

  final FlutterSecureStorage _storage;

  Future<AppState> restoreState() async {
    final sessionRaw = await _storage.read(key: _sessionKey);
    final themeRaw = await _storage.read(key: _themeKey);
    final biometricRaw = await _storage.read(key: _biometricKey);

    return AppState(
      session: sessionRaw == null ? null : AuthSession.fromJson(jsonDecode(sessionRaw) as Map<String, dynamic>),
      themeMode: themeRaw == 'light' ? ThemeMode.light : ThemeMode.dark,
      biometricEnabled: biometricRaw == 'true',
    );
  }

  Future<void> saveSession(AuthSession session) {
    return _storage.write(key: _sessionKey, value: jsonEncode(session.toJson()));
  }

  Future<void> clearSession() => _storage.delete(key: _sessionKey);

  Future<void> saveTheme(ThemeMode mode) {
    return _storage.write(key: _themeKey, value: mode == ThemeMode.light ? 'light' : 'dark');
  }

  Future<void> saveBiometricEnabled(bool value) {
    return _storage.write(key: _biometricKey, value: value.toString());
  }
}
