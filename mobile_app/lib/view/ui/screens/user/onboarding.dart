import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/widgets/onboardwidgets/onboard_widgets.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height / 7, 20, 0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    imageUrl:
                        "https://firebasestorage.googleapis.com/v0/b/omers-mobileapp-msc.appspot.com/o/omshop.png?alt=media&token=87315e95-ec41-4548-92f2-bae3f28f59f0", height: 200, width: 350,
                    fit: BoxFit.fitWidth,
                    
                  ),
                ),
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Hello! Welcome",
                  style: TextStyle(
                    fontFamily: 'Mula',
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    child: Text(
                      "We deliver on demand clothing items directly to your home.",
                      style: TextStyle(fontSize: 17, color: Colors.grey),
                      textAlign: TextAlign.center,
                    )),
                const SizedBox(
                  height: 60,
                ),
                const GetStartedButton(
                  key: Key("GetStarted"),
                  buttonText: "Get Started",
                  backgroundColor: Color(0xFF820ce8),
                  foregroundColor: Colors.white,
                ),
                const SizedBox(
                  height: 20,
                ),
                const AlreadyHaveAnAccountButton(
                  key: Key("haveAnAccount"),
                  buttonText: "I already have an account",
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

