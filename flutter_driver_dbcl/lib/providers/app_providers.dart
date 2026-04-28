import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/app_state.dart';
import '../models/auth_session.dart';
import '../models/user_profile.dart';
import '../services/biometric_service.dart';
import '../services/dbcl_api_service.dart';
import '../services/session_storage_service.dart';

final sessionStorageProvider = Provider<SessionStorageService>((ref) {
  return SessionStorageService();
});

final biometricServiceProvider = Provider<BiometricService>((ref) {
  return BiometricService();
});

final dbclApiServiceProvider = Provider<DbclApiService>((ref) {
  return DbclApiService();
});

final appControllerProvider = AsyncNotifierProvider<AppController, AppState>(AppController.new);

class AppController extends AsyncNotifier<AppState> {
  late final SessionStorageService _storage = ref.read(sessionStorageProvider);
  late final DbclApiService _api = ref.read(dbclApiServiceProvider);
  late final BiometricService _biometrics = ref.read(biometricServiceProvider);

  @override
  Future<AppState> build() async {
    final restored = await _storage.restoreState();
    final biometricAvailable = await _biometrics.isAvailable();
    return restored.copyWith(biometricAvailable: biometricAvailable);
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    final current = state.valueOrNull ?? const AppState();
    state = AsyncData(current.copyWith(isLoading: true));
    try {
      final session = await _api.login(email: email, password: password);
      await _storage.saveSession(session);
      state = AsyncData(current.copyWith(
        session: session,
        biometricAvailable: await _biometrics.isAvailable(),
        isLoading: false,
      ));
    } catch (_) {
      state = AsyncData(current.copyWith(isLoading: false));
      rethrow;
    }
  }

  Future<void> signup({
    required String name,
    required String phone,
    required String address,
    required String email,
    required String password,
    String? licenseImagePath,
    String? profilePhotoPath,
  }) async {
    final current = state.valueOrNull ?? const AppState();
    state = AsyncData(current.copyWith(isLoading: true));
    try {
      final session = await _api.signup(
        name: name,
        phone: phone,
        address: address,
        email: email,
        password: password,
        licenseImagePath: licenseImagePath,
        profilePhotoPath: profilePhotoPath,
      );
      await _storage.saveSession(session);
      state = AsyncData(current.copyWith(
        session: session,
        biometricAvailable: await _biometrics.isAvailable(),
        isLoading: false,
      ));
    } catch (_) {
      state = AsyncData(current.copyWith(isLoading: false));
      rethrow;
    }
  }

  Future<void> refreshProfile() async {
    final current = state.valueOrNull;
    if (current?.session == null) {
      return;
    }

    state = await AsyncValue.guard(() async {
      final user = await _api.fetchProfile(current!.session!.token);
      final nextSession = AuthSession(token: current.session!.token, user: user);
      await _storage.saveSession(nextSession);
      return current.copyWith(session: nextSession, isLoading: false);
    });
  }

  Future<void> updateProfile(UserProfile profile) async {
    final current = state.valueOrNull;
    if (current?.session == null) {
      return;
    }

    state = AsyncData(current!.copyWith(isLoading: true));
    state = await AsyncValue.guard(() async {
      final updated = await _api.updateProfile(current.session!.token, profile);
      final nextSession = AuthSession(token: current.session!.token, user: updated);
      await _storage.saveSession(nextSession);
      return current.copyWith(session: nextSession, isLoading: false);
    });
  }

  Future<void> toggleTheme() async {
    final current = state.valueOrNull ?? const AppState();
    final nextMode = current.themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await _storage.saveTheme(nextMode);
    state = AsyncData(current.copyWith(themeMode: nextMode));
  }

  Future<bool> toggleBiometric(bool enabled) async {
    final current = state.valueOrNull ?? const AppState();
    if (enabled) {
      final available = await _biometrics.isAvailable();
      if (!available || current.session == null) {
        state = AsyncData(current.copyWith(biometricAvailable: available));
        return false;
      }
    }

    await _storage.saveBiometricEnabled(enabled);
    state = AsyncData(current.copyWith(biometricEnabled: enabled));
    return true;
  }

  Future<bool> loginWithBiometrics() async {
    final current = state.valueOrNull;
    if (current?.session == null || !(current?.biometricEnabled ?? false)) {
      return false;
    }

    final ok = await _biometrics.authenticate();
    if (ok) {
      state = AsyncData(current!);
    }
    return ok;
  }

  Future<void> forgotPassword(String email) async {
    await _api.forgotPassword(email);
  }

  Future<void> logout() async {
    final current = state.valueOrNull ?? const AppState();
    await _storage.clearSession();
    await _storage.saveBiometricEnabled(false);
    state = AsyncData(
      current.copyWith(clearSession: true, biometricEnabled: false, isLoading: false),
    );
  }
}
