import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_provider.g.dart';

@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  AuthState build() {
    return AuthState.unauthenticated();
  }

  void login(String driverId, String password) {
    if ((driverId == "DEMO-2026" && password == "admin") || (driverId == "admin" && password == "admin")) {
      state = AuthState.authenticated(driverId: driverId, name: "Demo Driver");
    } else {
      state = AuthState.error("Invalid Credentials");
    }
  }

  void logout() {
    state = AuthState.unauthenticated();
  }
}

class AuthState {
  final bool isAuthenticated;
  final String? driverId;
  final String? name;
  final String? error;

  AuthState({required this.isAuthenticated, this.driverId, this.name, this.error});

  factory AuthState.unauthenticated() => AuthState(isAuthenticated: false);
  factory AuthState.authenticated({required String driverId, required String name}) => 
      AuthState(isAuthenticated: true, driverId: driverId, name: name);
  factory AuthState.error(String message) => AuthState(isAuthenticated: false, error: message);
}
