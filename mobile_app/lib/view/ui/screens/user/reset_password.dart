import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/providers/providers.dart';
import 'package:mobile_app/view/ui/screens/user/log_in_screen.dart';

class ResetPassword extends ConsumerStatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);

  @override
  ConsumerState<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends ConsumerState<ResetPassword> {
  final _fKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();





  @override
  Widget build(BuildContext context) {
    final authentication = ref.watch(fireAuthProvider);

    final emailField = TextFormField(
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


    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.fromLTRB(
            20, MediaQuery.of(context).size.height / 10, 20, 10),
        child: SingleChildScrollView(
          // ignore: avoid_unnecessary_containers
          child: Container(
            child: Form(
              key: _fKey,
              child: Column(
                children: [
                  const Text(
                    "Reset password",
                    style: TextStyle(
                      fontFamily: "Mula",
                      fontSize: 25,
                    ),
                  ),
                  const SizedBox(height: 20,),
                  const Text(
                      "Enter the email associated with your account and we'll send you a link with instructions to reset your password",
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                  const SizedBox(
                    height: 60,
                  ),
                  emailField,
                  const SizedBox(height: 35,),
                  ElevatedButton(
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
                   passwordReset(emailController.text, authentication);
                   if (isEmailValid()) {
                     emailController.clear();
                   }
            
                      },
                      child: const Text(
                        "Send instructions",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      )),
                  
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
  Future passwordReset(String email, FirebaseAuth authentication) async{

    try {
      if (_fKey.currentState!.validate()) {
      await authentication.sendPasswordResetEmail(email: email.trim());
      Fluttertoast.showToast(msg: "An email has been sent with further instructions.");
      // ignore: use_build_context_synchronously
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LogInScreen(),), (route) => false);
    }
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
      Fluttertoast.showToast(msg: "An email has been sent with further instructions.");
    }
  }

  bool isEmailValid(){
    bool emailIsValid = true;
    if (_fKey.currentState!.validate()) {
      return emailIsValid;
    }
    return false;
  }
}