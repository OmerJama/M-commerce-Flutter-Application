import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/main.dart';
import 'package:mobile_app/providers/providers.dart';
import 'package:mobile_app/view/ui/screens/user/reset_password.dart';
import 'package:mobile_app/view/ui/screens/user/sign_up_screen.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<LogInScreen> createState() => _NameState();
}

class _NameState extends ConsumerState<LogInScreen> {
  final _fKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    final authentication = ref.watch(fireAuthProvider);

    final emailField = TextFormField(
      key: const Key("logInEmail"),
      controller: emailController,
      autofocus: false,
      keyboardType: TextInputType.emailAddress,
      validator: (email) {
        if (email!.isEmpty) {
          return "Please enter your email";
        }
        if (!RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(email)) {
          return "Please enter a valid email address";
        }
        return null;
      },
      onSaved: (newValue) {
        emailController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.mail_outlined),
          hintText: "Email Address",
          contentPadding: const EdgeInsets.all(20),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.next,
    );

    final passwordField = TextFormField(
      key: const Key("logInPassword"),
      obscureText: true,
      controller: passwordController,
      autofocus: false,
      keyboardType: TextInputType.visiblePassword,
      validator: (password) {
        if (password!.isEmpty) {
          return "Please enter password";
        }
        if (!RegExp(r'^.{6,}$').hasMatch(password)) {
          return "Please enter a valid password";
        }
        return null;
      },
      onSaved: (newValue) {
        emailController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          hintText: "Password",
          contentPadding: const EdgeInsets.all(20),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.done,
    );

    return Scaffold(
      key: const Key("logInScreen"),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).size.height / 10, 20, 10),
        child: SingleChildScrollView(
          child: Form(
            key: _fKey,
            child: Column(
              children: [
                const Text(
                  "Log into your account",
                  style: TextStyle(
                    fontFamily: "Mula",
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                emailField,
                const SizedBox(
                  height: 10,
                ),
                passwordField,
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetPassword(),
                            ));
                      },
                      child: const Text(
                        "Forgot password?",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF820ce8)),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  key: const Key("loginButton"),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: const Color(0xFF820ce8),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                        Radius.elliptical(10, 10),
                      )),
                      minimumSize: const Size(350, 50),
                    ),
                    onPressed: () {
                      signIn(emailController.text, passwordController.text,
                          authentication);
                      FocusScope.of(context).unfocus();
                    },
                    child: const Text(
                      "Log in",
                      style: TextStyle(
                          fontSize: 17, fontWeight: FontWeight.bold),
                    )),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUpScreen(),
                            ));
                      },
                      child: const Text(
                        " Sign Up",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF820ce8)),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  void signIn(String email, String password, dynamic authentication) async {
    try {
      if (_fKey.currentState!.validate()) {
        await authentication
            .signInWithEmailAndPassword(email: email, password: password)
            .then((userId) => Fluttertoast.showToast(msg: "Login Successful"));
        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const MyApp(),), (route) => false);
        
      }
    } catch (e) {
      Fluttertoast.showToast(
          msg: "This password is invalid or the user does not exist.");
    }
  }
}
