import 'package:flutter/material.dart';
import 'package:mobile_app/view/ui/screens/user/log_in_screen.dart';
import 'package:mobile_app/view/ui/screens/user/sign_up_screen.dart';

class AlreadyHaveAnAccountButton extends StatelessWidget {
  final String buttonText;
  final dynamic backgroundColor;
  final dynamic foregroundColor;

  const AlreadyHaveAnAccountButton({
    required this.buttonText,
    required this.backgroundColor,
    required this.foregroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            foregroundColor: foregroundColor,
            backgroundColor: backgroundColor,
            elevation: 0),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LogInScreen(),
              ));
        },
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 17),
        ));
  }
}

class GetStartedButton extends StatelessWidget {
  final String buttonText;
  final dynamic backgroundColor;
  final dynamic foregroundColor;

  const GetStartedButton({
    required this.buttonText,
    required this.backgroundColor,
    required this.foregroundColor,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            foregroundColor: foregroundColor,
            shadowColor: Colors.grey,
            elevation: 2,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
              Radius.elliptical(10, 10),
            )),
            minimumSize: const Size(350, 50)),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>  const SignUpScreen(),
              ));
        },
        child: Text(
          buttonText,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ));
  }
}
