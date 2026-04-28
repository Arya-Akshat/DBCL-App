import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as io;

class AlcoholServerDataSource {
  HttpServer? _server;
  final Function(double confidence) onAlcoholDetected;

  AlcoholServerDataSource({required this.onAlcoholDetected});

  Future<void> start() async {
    final handler = const Pipeline()
        .addMiddleware(logRequests())
        .addHandler(_echoRequest);

    // Listen on all interfaces (0.0.0.0) at port 5001
    // Matches your Python bridge port
    _server = await io.serve(handler, InternetAddress.anyIPv4, 5001);
    debugPrint('Alcohol Server listening on port ${_server?.port}');
  }

  Future<Response> _echoRequest(Request request) async {
    if (request.url.path == 'alcohol_penalty') {
      // Logic from your Python/Kotlin code
      onAlcoholDetected(1.0);
      return Response.ok('OK');
    }
    
    if (request.method == 'POST' && request.url.path == 'trigger') {
      final payload = await request.readAsString();
      final data = jsonDecode(payload);
      final confidence = (data['confidence'] as num?)?.toDouble() ?? 1.0;
      onAlcoholDetected(confidence);
      return Response.ok(jsonEncode({'status': 'success'}));
    }

    return Response.notFound('Not Found');
  }

  Future<void> stop() async {
    await _server?.close();
    _server = null;
  }
}
