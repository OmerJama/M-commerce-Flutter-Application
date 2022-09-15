// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';
// import 'package:mobile_app/main.dart' as app;

// void main() {
//   group('App test', () {
//     IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//     testWidgets("Login and Logout Tests", (WidgetTester tester) async {
//       //setup
//       app.main();

//       final findAccountButton = find.text('I already have an account');

//       await Future.delayed(const Duration(seconds: 10));

//       await tester.pumpAndSettle();
//       //await Future.delayed(const Duration(seconds: 10));
//       await tester.tap(findAccountButton);
//       await tester.pumpAndSettle();
//       //test
//       expect(find.text('Log into your account'), findsOneWidget);

//       final Finder emailField = find.byType(TextFormField).first;
//       final Finder passwordField = find.byType(TextFormField).last;
//       final Finder loginButton = find.byKey(const Key('loginButton'));
//       final Finder profileButton = find.byKey(const Key('profile'));
//       final Finder logout = find.byKey(const Key('signOut'));
//       final Finder drawer = find.byKey(const Key('drawer'));

//       await tester.enterText(emailField, "omer.jama@hotmail.com");
//       await Future.delayed(const Duration(seconds: 3));
//       await tester.enterText(passwordField, "password");

//       await Future.delayed(const Duration(seconds: 3));
//       await tester.pumpAndSettle();

//       await Future.delayed(const Duration(seconds: 3));
//       await tester.tap(loginButton);

//       await Future.delayed(const Duration(seconds: 3));
//       await tester.pumpAndSettle();

//       expect(find.text('Products'), findsOneWidget);

//       //loging out
//       await tester.tap(profileButton);
//       await tester.pumpAndSettle();

//       await Future.delayed(const Duration(seconds: 3));

//       // scroll down on the profile option
//       await tester.dragUntilVisible(logout, drawer, const Offset(0, -500));
//       await tester.tap(logout);
//       await tester.pumpAndSettle();

//       expect(find.text('Hello! Welcome'), findsOneWidget);
//     });
//     testWidgets("Register new account and view home page",
//         (WidgetTester tester) async {
//       //setup
//       app.main();
//       // Register account
//       await Future.delayed(const Duration(seconds: 10));
//       // register new account
//       await tester.pumpAndSettle();
//       final findCreateAccount = find.byKey(const Key('GetStarted'));

//       await tester.tap(findCreateAccount);
//       await tester.pumpAndSettle();
//       //test
//       expect(find.text("Create an account"), findsOneWidget);

//       final Finder firstNameField = find.byType(TextFormField).first;
//       final Finder surnameField = find.byKey(const Key('secondName'));
//       final Finder emailFieldReg = find.byKey(const Key('emailAddress'));
//       final Finder passwordFieldFirst = find.byKey(const Key('password'));
//       final Finder passwordFieldSecond = find.byType(TextFormField).last;
//       final Finder createAccount = find.byKey(const Key('createAccount'));

//       await Future.delayed(const Duration(seconds: 3));
//       await tester.enterText(firstNameField, "Omer Omer");
//       await tester.pumpAndSettle();
//       await tester.enterText(surnameField, "Jama Jama");
//       await tester.pumpAndSettle();
//       await Future.delayed(const Duration(seconds: 3));
//       await tester.enterText(emailFieldReg, "omarmjama49@gmail.com");
//       await tester.pumpAndSettle();
//       await Future.delayed(const Duration(seconds: 3));
//       await tester.enterText(passwordFieldFirst, "password");
//       await tester.pumpAndSettle();
//       await tester.enterText(passwordFieldSecond, "password");
//       await Future.delayed(const Duration(seconds: 3));
//       await tester.testTextInput.receiveAction(TextInputAction.done);
//       await tester.pumpAndSettle();

//       await Future.delayed(const Duration(seconds: 3));
//       await tester.pumpAndSettle();

//       await Future.delayed(const Duration(seconds: 3));
//       await tester.tap(createAccount); //try run
//       await tester.pumpAndSettle();

//       await Future.delayed(const Duration(seconds: 5));
//       await tester.pumpAndSettle();

//       // manual verify email
//       await Future.delayed(const Duration(seconds: 40));
//       await tester.pumpAndSettle();
//       await Future.delayed(const Duration(seconds: 30));

//       //expect to see home screen products
//       expect(find.text('Products'), findsOneWidget);
//     });
//   });
// }
