import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tawk/flutter_tawk.dart';

class CustomerLiveChat extends StatefulWidget {
  const CustomerLiveChat({Key? key}) : super(key: key);

  @override
  State<CustomerLiveChat> createState() => _CustomerLiveChatState();
}

class _CustomerLiveChatState extends State<CustomerLiveChat> {
  @override
  Widget build(BuildContext context) {
    String directChatLink = "https://tawk.to/chat/62fcdf8137898912e9638601/1galsi4hr";

    return Scaffold(
      body: SafeArea(
        child: Tawk(
          directChatLink: directChatLink,
          visitor: TawkVisitor(
            name: FirebaseAuth.instance.currentUser!.displayName,
            email: FirebaseAuth.instance.currentUser!.email,
          ),
        ),
      ),
    );
  }
}