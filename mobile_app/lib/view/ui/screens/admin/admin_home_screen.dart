import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/providers/providers.dart';
import 'package:mobile_app/widgets/adminwidgets/admin_body.dart';

class AdminHome extends ConsumerStatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  ConsumerState<AdminHome> createState() => _AdminHomeState();
}

enum Pages { home, manage }

class _AdminHomeState extends ConsumerState<AdminHome> {
  MaterialColor selectedColour = Colors.blue;
  Color notSelectedColour = Colors.black;
  Pages selectedPages = Pages.home;
  @override
  Widget build(BuildContext context) {
    final authentication = ref.watch(fireAuthProvider);
    //admin adapted from https://github.com/Santos-Enoque/complete_flutter_ecommerce/tree/master/lib

    return Scaffold(
      bottomNavigationBar: menuBar(context),
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        leading: IconButton(
          onPressed: () {
            authentication.signOut();
            
          },
          icon: const Icon(
            Icons.logout,
            color: Colors.black,
          ),
        ),
        title: selectedPages == Pages.home
            ? Text(
                "Dashboard",
                style: textStyleTitleAdmin(),
              )
            : Text(
                "Manage store",
                style: textStyleTitleAdmin(),
              ),
        centerTitle: true,
      ),
      body: BodyScreen(selectedPage: selectedPages, page: Pages.home, textStyle: textStyleTitleAdmin(),),
    );
  }

  TextStyle textStyleTitleAdmin() {
    return const TextStyle(
      fontFamily: 'Mula',
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );
  }

  Row menuBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            foregroundColor: Colors.black,
            elevation: 0,
          ),
          onPressed: () {
            setState(() {
              selectedPages = Pages.home;
            });
          },
          icon: Icon(
            Icons.dashboard,
            color:
                selectedPages == Pages.home ? selectedColour : notSelectedColour,
          ),
          label: const Text(
            "Home",
            style: TextStyle(
              fontFamily: 'Mula',
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              foregroundColor: Colors.black,
              elevation: 0,
            ),
            onPressed: () {
              setState(() {
                selectedPages = Pages.manage;
              });
            },
            icon: Icon(
              Icons.local_shipping_outlined,
              color: selectedPages == Pages.manage
                  ? selectedColour
                  : notSelectedColour,
            ),
            label: const Text(
              "Manage Store",
              style: TextStyle(fontFamily: 'Mula', fontWeight: FontWeight.bold),
            )),
      ],
    );
  }

  
}
