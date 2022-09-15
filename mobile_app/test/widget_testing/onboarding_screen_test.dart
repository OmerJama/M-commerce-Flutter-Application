import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/view/ui/screens/user/onboarding.dart';
import 'package:flutter/material.dart';

import '../mock.dart';

void main() {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
    WidgetsBinding.instance.renderView.configuration =
        TestViewConfiguration(size: const Size(1200.0, 1980.0));
  });
  group("Onboarding screen widget test", () {
    testWidgets("Get started button", (widgetTester) async {
      final button = find.byKey(const ValueKey("GetStarted"));
      final screen = find.byKey(const ValueKey('signUpScreen'));
      await widgetTester.pumpWidget(
          const ProviderScope(child: MaterialApp(home: OnboardingScreen())));
      await widgetTester.tap(button);
      await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));

      expect(screen, findsOneWidget);
    });
    testWidgets("Already have an account button", (widgetTester) async {
      final button = find.byKey(const ValueKey("haveAnAccount"));
      final screen = find.byKey(const ValueKey('logInScreen'));
      await widgetTester.pumpWidget(
          const ProviderScope(child: MaterialApp(home: OnboardingScreen())));
      await widgetTester.tap(button);
      await widgetTester.pumpAndSettle(const Duration(milliseconds: 500));

      expect(screen, findsOneWidget);
    });
  });
}
