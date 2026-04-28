import 'package:flutter/material.dart';

import 'auth_session.dart';
import 'user_profile.dart';

class AppState {
  const AppState({
    this.session,
    this.themeMode = ThemeMode.dark,
    this.biometricEnabled = false,
    this.biometricAvailable = false,
    this.isLoading = false,
  });

  final AuthSession? session;
  final ThemeMode themeMode;
  final bool biometricEnabled;
  final bool biometricAvailable;
  final bool isLoading;

  bool get isAuthenticated => session != null;
  UserProfile? get currentUser => session?.user;

  AppState copyWith({
    AuthSession? session,
    bool clearSession = false,
    ThemeMode? themeMode,
    bool? biometricEnabled,
    bool? biometricAvailable,
    bool? isLoading,
  }) {
    return AppState(
      session: clearSession ? null : (session ?? this.session),
      themeMode: themeMode ?? this.themeMode,
      biometricEnabled: biometricEnabled ?? this.biometricEnabled,
      biometricAvailable: biometricAvailable ?? this.biometricAvailable,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
