import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mobile_app/view/authentication.dart';
import 'package:mobile_app/view/ui/screens/admin/admin_home_screen.dart';
import 'package:mobile_app/view/ui/screens/user/home_screen.dart';
import 'package:mobile_app/view/ui/screens/user/onboarding.dart';
import 'package:mobile_app/firebase_options.dart';
import 'package:mobile_app/view/ui/screens/user/verify_email.dart';
import 'package:dcdg/dcdg.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  //auto generated
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  Stripe.publishableKey =
      "pk_test_51LOpzaKbb99QhNfMkZBum06wffopELzGZvnvFxzlRL1D0gBYDk6E9Ankt7FvelQgCTIssc3pZJP4ChBlGQ67cKRw00RJvtrRpx";
  FirebaseAppCheck firebaseAppCheck = FirebaseAppCheck.instance;
  firebaseAppCheck.activate();
  //taken from firebase appcheck following
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'M-commerce app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: DoubleBackToCloseApp(
          snackBar: const SnackBar(content: Text("Press back again to exit")),
          child: AuthenticationWidget(
            signedInUser: (context) {
              return const HomeScreen();
            },
            nonSignedInUser: (context) {
              return const OnboardingScreen();
            },
            adminSignedIn: (context) {
              return const AdminHome();
            },
            verifyNeeded: (context) {
              return const VerifyScreen();
            },
          ),
        ),
      ),
    );
  }
}
