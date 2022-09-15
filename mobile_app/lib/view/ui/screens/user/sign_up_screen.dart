import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/view/ui/screens/user/log_in_screen.dart';
import 'package:mobile_app/view/ui/screens/user/verify_email.dart';
import 'package:mobile_app/models/user_model.dart';
import 'package:mobile_app/providers/providers.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _fKey = GlobalKey<FormState>();

  late FocusNode focusNode1 = FocusNode();
  late FocusNode focusNode2 = FocusNode();
  late FocusNode focusNode3 = FocusNode();

  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authentication = ref.watch(fireAuthProvider);
    

    final firstNameField = TextFormField(
      key: const Key('signUpFirstNameField'),
      controller: firstNameEditingController,
      autofocus: false,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      enableInteractiveSelection: false,
      validator: (firstName) {
        if (firstName!.isEmpty) {
          return "Please enter a name";
        }
        if (!RegExp(r'^.{2,}$').hasMatch(firstName)) {
          return "Please enter a valid name (Min. 2 characters)";
        }
        return null;
      },
      onSaved: (newValue) {
        firstNameEditingController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          hintText: "First Name",
          contentPadding: const EdgeInsets.all(20),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.next,
      focusNode: focusNode1,
    );

    final secondNameField = TextFormField(
      key: const Key('secondName'),
      controller: secondNameEditingController,
      autofocus: false,
      focusNode: focusNode2,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      validator: (secondName) {
        if (secondName!.isEmpty) {
          return "Please enter a name";
        }
        if (!RegExp(r'^.{2,}$').hasMatch(secondName)) {
          return "Please enter a valid name (Min. 2 characters)";
        }
        return null;
      },
      onSaved: (newValue) {
        secondNameEditingController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.person),
          hintText: "Second Name",
          contentPadding: const EdgeInsets.all(20),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.next,
    );

    final emailField = TextFormField(
      key: const Key('emailAddress'),
      controller: emailEditingController,
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
        emailEditingController.text = newValue!;
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
      key: const Key('password'),
      controller: passwordEditingController,
      autofocus: false,
      obscureText: true,
      validator: (password) {
        if (password!.isEmpty) {
          return "Please enter password";
        }
        if (!RegExp(r'^.{6,}$').hasMatch(password)) {
          return "Password requirements: min. 6 characters";
        }
        return null;
      },
      onSaved: (newValue) {
        passwordEditingController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          hintText: "Password",
          contentPadding: const EdgeInsets.all(20),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.next,
    );

    final confirmPasswordField = TextFormField(
      key: const Key('signUpConfirmPasswordField'),
      controller: confirmPasswordEditingController,
      autofocus: false,
      obscureText: true,
      validator: (value) {
        if (value != passwordEditingController.text) {
          return "Passwords do not match";
        }
        return null;
      },
      onSaved: (newValue) {
        confirmPasswordEditingController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock),
          hintText: "Confirm Password",
          contentPadding: const EdgeInsets.all(20),
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.done,
    );

    return Scaffold(
      key: const Key('signUpScreen'),
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
                  "Create an account",
                  style: TextStyle(
                    fontFamily: "Mula",
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 70,
                ),
                firstNameField,
                const SizedBox(
                  height: 10,
                ),
                secondNameField,
                const SizedBox(
                  height: 10,
                ),
                emailField,
                const SizedBox(
                  height: 10,
                ),
                passwordField,
                const SizedBox(
                  height: 10,
                ),
                confirmPasswordField,
                const SizedBox(
                  height: 60,
                ),
                ElevatedButton(
                  key: const Key("createAccount"),
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
                      signUp(emailEditingController.text, passwordEditingController.text, authentication, firstNameEditingController.text);
                      
                    },
                    child: const Text(
                      "Create an Account",
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
                      "Already have an account?",
                      style: TextStyle(),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LogInScreen(),
                            ));
                      },
                      child: const Text(
                        " Sign In",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF820ce8)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  "By creating an account, you agree to our terms and conditions.",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey),
                )
              ],
            ),
          ),
        ),
      )),
    );
  }

  void signUp(String email, String password, FirebaseAuth authentication, String displayname) async {
  
    try {
       if (_fKey.currentState!.validate()) {
      await authentication.createUserWithEmailAndPassword(email: email, password: password).then((value) async {
      await FirebaseAuth.instance.currentUser?.updateDisplayName(displayname);
        return sendDetailsToFirestore();
      });
    }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }



  sendDetailsToFirestore() async {
    try {
      User? user = ref.watch(fireAuthProvider).currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    UserModel userModel = UserModel();

    userModel.email = user!.email;
    userModel.uid = user.uid;
    userModel.firstName = firstNameEditingController.text;
    userModel.secondName = secondNameEditingController.text;

    await firestore.collection("users").doc(user.uid).set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully, please log in");
    // ignore: use_build_context_synchronously
    Navigator.push(context, MaterialPageRoute(builder: (context) => const VerifyScreen(),));
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
    

  }
  
  
  }
