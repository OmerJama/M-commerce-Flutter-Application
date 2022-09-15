import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/view/ui/screens/user/user_bags_screen.dart';
import 'package:mobile_app/view/ui/screens/user/users_orders_screen.dart';
import 'package:mobile_app/view/ui/screens/user/wishlist_screen.dart';
import 'package:mobile_app/providers/providers.dart';
import 'package:mobile_app/widgets/homescreencomponents/categories_row.dart';
import 'package:mobile_app/widgets/homescreencomponents/drawer_page.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';

import 'package:mobile_app/widgets/homescreencomponents/home_banner.dart';
import 'package:mobile_app/widgets/homescreencomponents/product_display.dart';
import 'package:mobile_app/widgets/homescreencomponents/profile_button.dart';
import 'package:mobile_app/widgets/homescreencomponents/search_field.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchController = TextEditingController();
    final fireStoreProvider = ref.read(firestoreProvider);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      key: const Key('userHome'),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: Padding(
                padding: const EdgeInsets.only(top: 15),
                child: Row(
                  children: [
                    SearchField(
                        screenSize: screenSize,
                        searchController: searchController),
                     SizedBox(
                      height: 0,
                      width: MediaQuery.of(context).size.width/13,
                    ),
                    const ProfileButton()
                  ],
                ),
              ),
            ),
            const HomeBanner(),

            const SizedBox(
              height: 10,
            ),

            //streambuilder here that displays all the categories by name horizontally
            CategoryRow(fireStoreProvider: fireStoreProvider),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 8),
              child: Row(
                children: const [
                  Text(
                    "Products",
                    key: Key("productsText"),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ],
              ),
            ),
            ProductDisplay(fireStoreProvider: fireStoreProvider),
          ],
        ),
      )),
      bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          backgroundColor: Colors.blue.shade700,
          selectedItemColor: Colors.black,
          iconSize: 30,
          items: [
            const BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  color: Colors.black,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: IconButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const UserOrders(),
                          ));
                    },
                    icon: SvgPicture.asset('assets/icons/ordericon.svg')),
                label: "Orders"),
            BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>  const UserBag(),
                        ));
                  },
                  icon: const Icon(
                    Icons.shopping_bag_outlined,
                    color: Colors.black,
                  ),
                ),
                label: "Bag"),
            BottomNavigationBarItem(
                icon: IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WishlistScreen(),
                        ));
                  },
                  icon: const Icon(
                    Icons.favorite_outline,
                    color: Colors.black,
                  ),
                ),
                label: "Wishlist"),
          ]),
      endDrawer: const DrawerPage(),
    );
  }
}



