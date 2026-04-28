import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/auth_session.dart';
import '../models/event_record.dart';
import '../models/score_summary.dart';
import '../models/trip_record.dart';
import '../models/user_profile.dart';
import 'app_config.dart';

class ApiException implements Exception {
  const ApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

class DbclApiService {
  DbclApiService({
    http.Client? client,
    this.baseUrl = AppConfig.defaultBaseUrl,
  }) : _client = client ?? http.Client();

  final http.Client _client;
  final String baseUrl;

  Map<String, String> _headers([String? token]) => {
        'Content-Type': 'application/json',
        if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
      };

  dynamic _decodeBody(http.Response response) {
    if (response.body.isEmpty) {
      return null;
    }
    return jsonDecode(response.body);
  }

  Never _throwForResponse(http.Response response, {String fallback = 'Request failed'}) {
    final body = _decodeBody(response);
    final message = body is Map<String, dynamic>
        ? body['detail']?.toString() ?? body['message']?.toString() ?? fallback
        : fallback;
    throw ApiException(message);
  }

  Future<AuthSession> signup({
    required String name,
    required String phone,
    required String address,
    required String email,
    required String password,
    String? licenseImagePath,
    String? profilePhotoPath,
  }) async {
    final payload = {
      'name': name,
      'phone': phone,
      'address': address,
      'email': email,
      'password': password,
      'license_image_path': licenseImagePath,
      'profile_photo_path': profilePhotoPath,
    };

    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/signup'),
        headers: _headers(),
        body: jsonEncode(payload),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return AuthSession.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      }
      _throwForResponse(response, fallback: 'Signup failed');
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('Unable to reach backend server for signup.');
    }
  }

  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final payload = {
      'email': email,
      'password': password,
    };

    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/login'),
        headers: _headers(),
        body: jsonEncode(payload),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return AuthSession.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      }
      _throwForResponse(response, fallback: 'Login failed');
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('Unable to reach backend server for login.');
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      final response = await _client.post(
        Uri.parse('$baseUrl/auth/forgot-password'),
        headers: _headers(),
        body: jsonEncode({'email': email}),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return;
      }
      _throwForResponse(response, fallback: 'Forgot password request failed');
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('Unable to reach backend server.');
    }
  }

  Future<UserProfile> fetchProfile(String token) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/user/profile'),
        headers: _headers(token),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return UserProfile.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      }
      _throwForResponse(response, fallback: 'Failed to load profile');
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('Unable to reach backend server.');
    }
  }

  Future<UserProfile> updateProfile(String token, UserProfile profile) async {
    try {
      final response = await _client.put(
        Uri.parse('$baseUrl/user/profile'),
        headers: _headers(token),
        body: jsonEncode(profile.toJson()),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return UserProfile.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      }
      _throwForResponse(response, fallback: 'Failed to update profile');
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('Unable to reach backend server.');
    }
  }

  Future<List<EventRecord>> fetchEvents(String token) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/events'),
        headers: _headers(token),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final body = jsonDecode(response.body) as List<dynamic>;
        return body.map((item) => EventRecord.fromJson(item as Map<String, dynamic>)).toList();
      }
      _throwForResponse(response, fallback: 'Failed to load events');
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('Unable to reach backend server.');
    }
  }

  Future<List<TripRecord>> fetchTrips(String token) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/trips'),
        headers: _headers(token),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final body = jsonDecode(response.body) as List<dynamic>;
        return body.map((item) => TripRecord.fromJson(item as Map<String, dynamic>)).toList();
      }
      _throwForResponse(response, fallback: 'Failed to load trips');
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('Unable to reach backend server.');
    }
  }

  Future<ScoreSummary> fetchScore(String token) async {
    try {
      final response = await _client.get(
        Uri.parse('$baseUrl/score'),
        headers: _headers(token),
      );
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return ScoreSummary.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      }
      _throwForResponse(response, fallback: 'Failed to load score');
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('Unable to reach backend server.');
    }
  }
}
