import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/providers/providers.dart';

class AuthenticationWidget extends ConsumerWidget {
  final WidgetBuilder signedInUser;
  final WidgetBuilder nonSignedInUser;
  final WidgetBuilder adminSignedIn;
  final WidgetBuilder verifyNeeded;
  const AuthenticationWidget(
      {required this.signedInUser, required this.nonSignedInUser, required this.adminSignedIn, required this.verifyNeeded, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authChanges = ref.watch(authChangesProvider);
    const adminEmail = "admin@admin.com";

    return authChanges.when(
      data: (user) {
        if (user == null) {
          return nonSignedInUser(context);
        }
        else if(user.email == adminEmail){
          return adminSignedIn(context);
        }
        else if(!user.emailVerified){
          return verifyNeeded(context);
        }
        return signedInUser(context);
      },
      error: ((error, stackTrace) => const Scaffold(
            body: Center(
              child: Text("Error code 001"),
            ),
          )),
      loading: () => const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
