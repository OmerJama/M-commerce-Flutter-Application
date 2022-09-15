import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/view/ui/screens/user/onboarding.dart';
import 'package:mobile_app/view/ui/screens/user/user_bags_screen.dart';
import 'package:mobile_app/view/ui/screens/user/users_orders_screen.dart';
import 'package:mobile_app/view/ui/screens/user/wishlist_screen.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile_app/widgets/homescreencomponents/about_us.dart';
import 'package:mobile_app/widgets/homescreencomponents/customer_service.dart';
import 'package:mobile_app/widgets/homescreencomponents/user_faq.dart';

class DrawerPage extends StatelessWidget {
  const DrawerPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: const Key('drawer'),
      backgroundColor: Colors.white,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Welcome, ${FirebaseAuth.instance.currentUser!.displayName!}!",
                  style: const TextStyle(
                      fontFamily: 'Grotesk',
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
                const Divider(),
                const SizedBox(height: 20,),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                      imageUrl:
                          "https://firebasestorage.googleapis.com/v0/b/omers-mobileapp-msc.appspot.com/o/omshop.png?alt=media&token=87315e95-ec41-4548-92f2-bae3f28f59f0",
                          height: 150,
                          width: 150,
                          
                          ),
                ),
                const SizedBox(height: 30,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 255,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              elevation: 0.3,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const UserOrders()));
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset("assets/icons/ordericon.svg"),
                                const SizedBox(
                                  width: 20,
                                ),
                                const Text("View Orders"),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 255,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              elevation: 0.3,
                              padding: const EdgeInsets.all(20),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const UserBag()));
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.shopping_bag),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("View bag"),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 255,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              elevation: 0.3,
                              minimumSize: const Size(100, 10),
                              padding: const EdgeInsets.all(20),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const WishlistScreen()));
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.favorite_outlined),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("View wishlist"),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 255,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              elevation: 0.3,
                              padding: const EdgeInsets.all(20),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const CustomerServiceScreen()));
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.chat),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Customer Service"),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 255,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              elevation: 0.3,
                              minimumSize: const Size(100, 10),
                              padding: const EdgeInsets.all(20),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const FaqScreen()));
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.question_mark_outlined),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("FAQs"),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 255,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              elevation: 0.3,
                              padding: const EdgeInsets.all(20),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const AboutUs()));
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.info_outline),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("About us"),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 255,
                        child: ElevatedButton(
                          key: const Key('signOut'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.black,
                              elevation: 0.3,
                              padding: const EdgeInsets.all(20),
                            ),
                            onPressed: () async {
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const OnboardingScreen(),
                                  ));
                              await FirebaseAuth.instance.signOut();
                            },
                            child: Row(
                              children: const [
                                Icon(Icons.logout),
                                SizedBox(
                                  width: 20,
                                ),
                                Text("Sign out"),
                              ],
                            )),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
