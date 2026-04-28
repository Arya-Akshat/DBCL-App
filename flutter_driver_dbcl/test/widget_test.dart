import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:driver_dbcl_flutter/models/app_state.dart';
import 'package:driver_dbcl_flutter/providers/app_providers.dart';
import 'package:driver_dbcl_flutter/screens/auth_gate.dart';
import 'package:flutter/material.dart';

class _FakeAppController extends AppController {
  @override
  Future<AppState> build() async => const AppState();
}

void main() {
  testWidgets('shows auth flow shell', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          appControllerProvider.overrideWith(_FakeAppController.new),
        ],
        child: const MaterialApp(
          home: AuthGate(),
        ),
      ),
    );

    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));
    expect(find.text('Driver Behaviour & Credit Ledger'), findsOneWidget);
  });
}
