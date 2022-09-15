import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/view/ui/screens/user/home_screen.dart';
import 'package:mobile_app/view/ui/screens/user/log_in_screen.dart';

class VerifyScreen extends StatefulWidget {
  const VerifyScreen({Key? key}) : super(key: key);

  @override
  State<VerifyScreen> createState() => _VerifyScreenState();
}
bool isEmailVerified = false;
final authentication = FirebaseAuth.instance;
late User user;
late Timer timer;



class _VerifyScreenState extends State<VerifyScreen> {
  @override
void initState() {
  super.initState();

  isEmailVerified = authentication.currentUser!.emailVerified;
  if (!isEmailVerified) {
    sendEmail();
    timer = Timer.periodic(const Duration(seconds: 3), (timer) { checkEmailVerified();});
  }
}
Future sendEmail() async{
  try {
  final user = authentication.currentUser!;
  await user.sendEmailVerification();
}  catch (e) {
  Fluttertoast.showToast(msg: "Instructions have already been sent to your email" );
}
}

@override
void dispose() {
  timer.cancel();
  super.dispose();
}


  @override
  Widget build(BuildContext context) {
    return isEmailVerified ? const HomeScreen() : Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
                0, 40, 20, 0),
            child: Column(
              children: [
                Row(children: [
                  IconButton(onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const LogInScreen(),), (route) => false);
                    authentication.signOut();
                  }, icon: const Icon(Icons.arrow_back_sharp)),
                const Text("Log in page", style: TextStyle(
                  fontFamily: 'Mula'
                ),),

                ]),
                const SizedBox(height: 80,),
                CachedNetworkImage(
                  imageUrl:
                      "https://firebasestorage.googleapis.com/v0/b/omers-mobileapp-msc.appspot.com/o/envelope-of-white-paper.png?alt=media&token=5dd1825d-d21a-4b58-962a-472560f14f18",
                  fit: BoxFit.fitWidth,
                  height: 170,
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Check your email",
                  key: Key("checkEmailText"),
                  style: TextStyle(
                    fontFamily: 'Mula',
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: Text(
                      "To verify your email address, click the link in the email we sent you",
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                      textAlign: TextAlign.center,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkEmailVerified() async {
    await authentication.currentUser?.reload();
    if (!mounted) {
      return;
    }
    setState(() {
      isEmailVerified = authentication.currentUser!.emailVerified;
    });
    if (isEmailVerified) {
      timer.cancel();
    }
    
  }
  
}
