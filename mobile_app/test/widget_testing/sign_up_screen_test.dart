import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/view/ui/screens/user/sign_up_screen.dart';

import '../mock.dart';

Future<void> main() async {
  setupFirebaseAuthMocks();

  setUpAll(() async {
    await Firebase.initializeApp();
    WidgetsBinding.instance.renderView.configuration =  TestViewConfiguration(size: const Size(1200.0, 1980.0));
  });
  group("Sign up screen widget test", () {
    final firstName = find.byKey(const ValueKey("signUpFirstNameField"));
    final secondName = find.byKey(const ValueKey("secondName"));
    final email = find.byKey(const ValueKey("emailAddress"));
    final password = find.byKey(const ValueKey("password"));
    final confirmPassword =
        find.byKey(const ValueKey("signUpConfirmPasswordField"));
    const goodFirstNameInput = "Omer";
    const goodSecondNameIput = "Jama";
    const goodEmailInput = "omer.jama@hotmail.com";
    const goodPasswordInput = "password";
    const goodConfirmPasswordInput = "password";

    testWidgets(
        "Account should not be created with an invalid or empty first name",
        (widgetTester) async {
      final screen = find.byKey(const ValueKey('signUpScreen'));
      final button = find.byKey(const ValueKey("createAccount"));
      await widgetTester.pumpWidget(
          const ProviderScope(child: MaterialApp(home: SignUpScreen())));
      await widgetTester.enterText(firstName, "l");
      await widgetTester.enterText(secondName, goodSecondNameIput);
      await widgetTester.enterText(email, goodEmailInput);
      await widgetTester.enterText(password, goodPasswordInput);
      await widgetTester.enterText(confirmPassword, goodConfirmPasswordInput);
      await widgetTester.tap(button);
      await widgetTester.pumpAndSettle();
      expect(screen, findsOneWidget);
    });

    testWidgets(
        "Account should not be created with an invalid or empty second name",
        (widgetTester) async {
      final screen = find.byKey(const ValueKey('signUpScreen'));
      final button = find.byKey(const ValueKey("createAccount"));
      await widgetTester.pumpWidget(
          const ProviderScope(child: MaterialApp(home: SignUpScreen())));
      await widgetTester.enterText(firstName, goodFirstNameInput);
      await widgetTester.enterText(secondName, "l");
      await widgetTester.enterText(email, goodEmailInput);
      await widgetTester.enterText(password, goodPasswordInput);
      await widgetTester.enterText(confirmPassword, goodConfirmPasswordInput);
      await widgetTester.tap(button);
      await widgetTester.pumpAndSettle();
      expect(screen, findsOneWidget);
    });

    testWidgets(
        "Account should not be created with an invalid or empty email address",
        (widgetTester) async {
      final screen = find.byKey(const ValueKey('signUpScreen'));
      final button = find.byKey(const ValueKey("createAccount"));

      await widgetTester.pumpWidget(
          const ProviderScope(child: MaterialApp(home: SignUpScreen())));
      await widgetTester.enterText(firstName, goodFirstNameInput);
      await widgetTester.enterText(secondName, goodSecondNameIput);
      await widgetTester.enterText(email, "Loremipsum1212341");
      await widgetTester.enterText(password, goodPasswordInput);
      await widgetTester.enterText(confirmPassword, goodConfirmPasswordInput);
      await widgetTester.tap(button);
      await widgetTester.pumpAndSettle();
      expect(screen, findsOneWidget);
    });

    testWidgets(
        "Account should not be created with an invalid or password that does not match with confirmed password",
        (widgetTester) async {
      final screen = find.byKey(const ValueKey('signUpScreen'));
      final button = find.byKey(const ValueKey("createAccount"));

      await widgetTester.pumpWidget(
          const ProviderScope(child: MaterialApp(home: SignUpScreen())));
      await widgetTester.enterText(firstName, goodFirstNameInput);
      await widgetTester.enterText(secondName, goodSecondNameIput);
      await widgetTester.enterText(email, goodEmailInput);
      await widgetTester.enterText(password, "badpassword");
      await widgetTester.enterText(confirmPassword, goodConfirmPasswordInput);
      await widgetTester.tap(button);
      await widgetTester.pumpAndSettle();
      expect(screen, findsOneWidget);
    });
    // testWidgets(
    //     "Account should be created when all fields are valid and passwords match",
    //     (widgetTester) async {
    //   final screen = find.byKey(const ValueKey('verifyEmailScreen'));
    //   final button = find.byKey(const ValueKey("createAccount"));

    //   await widgetTester.pumpWidget(
    //       const ProviderScope(child: MaterialApp(home: SizedBox(child: SignUpScreen()))));
    //   await widgetTester.enterText(firstName, goodFirstNameInput);
    //   await widgetTester.enterText(secondName, goodSecondNameIput);
    //   await widgetTester.enterText(email, goodEmailInput);
    //   await widgetTester.enterText(password, goodPasswordInput);
    //   await widgetTester.enterText(confirmPassword, goodConfirmPasswordInput);
    //   await widgetTester.pumpAndSettle();
    //   await widgetTester.tap(button);
    //   await widgetTester.pumpAndSettle(const Duration(seconds: 2));
    //   expect(screen, findsOneWidget);
    // });
  });
}
