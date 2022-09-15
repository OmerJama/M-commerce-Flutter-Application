import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_app/models/cart_item_model.dart';
import 'package:mobile_app/providers/providers.dart';
import 'package:mobile_app/view/ui/screens/user/user_bags_screen.dart';

class WishlistScreen extends ConsumerStatefulWidget {
  const WishlistScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<WishlistScreen> createState() => _WishlistScreenState();
}

class _WishlistScreenState extends ConsumerState<WishlistScreen> {
  @override
  Widget build(BuildContext context) {
    final fireStoreProvider = ref.read(firestoreProvider);
    final authentication = FirebaseAuth.instance;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Your Wishlist",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Grotesk',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        bottomOpacity: 0.1,
        elevation: 1,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const UserBag(),
                    ));
              },
              icon: const Icon(Icons.shopping_bag_outlined))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream: fireStoreProvider!.firestore
                  .collection("Wishlists")
                  .where('uid', isEqualTo: authentication.currentUser!.uid)
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Text("");
                }
                if (snapshot.data!.docs.isEmpty) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 6,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Lottie.asset("assets/anim/anotheremptybox.json",
                            width: 200, repeat: true),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "Looks like your wishlist is empty!",
                        style: TextStyle(
                            fontFamily: 'Grotesk', fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Explore more and add some more items",
                        style: TextStyle(fontFamily: 'Grotesk'),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(150, 40),
                              backgroundColor: Colors.blue.shade600),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Start shopping"))
                    ],
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final document = snapshot.data!.docs[index];
                    return Column(
                      children: [
                        Slidable(
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(),
                              children: [
                                SlidableAction(
                                  icon: Icons.delete,
                                  backgroundColor: Colors.red.shade700,
                                  onPressed: (context) {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          title: const Text(
                                            "Please confirm",
                                            style:
                                                TextStyle(fontFamily: 'Mula'),
                                          ),
                                          content: Text(
                                              "Are you sure you want to remove the ${snapshot.data!.docs[index].get('name')} from your wishlist?"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  snapshot.data!.docs[index]
                                                      .reference
                                                      .delete()
                                                      .whenComplete(() {
                                                    Navigator.pop(context);
                                                    Fluttertoast.showToast(
                                                        msg: "Product deleted");
                                                  });
                                                },
                                                child: const Text("Yes")),
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                child: const Text("Cancel"))
                                          ],
                                        );
                                      },
                                    );
                                  },
                                )
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              color: Colors.white,
                              child: Row(
                                children: [
                                  // ignore: sized_box_for_whitespace
                                  Container(
                                    width: 100,
                                    height: 100,
                                    child: ClipRRect(
                                      child: CachedNetworkImage(
                                          imageUrl: document['ImageUrl'],
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.fill),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(document['name'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontFamily: 'Grotesk',
                                                fontSize: 15)),
                                        Text(
                                          "£${document['price'].toStringAsFixed(2)}",
                                          style: const TextStyle(
                                              fontFamily: 'Grotesk',
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(
                                          "Size | ${document['Size']} ",
                                          style: const TextStyle(
                                              fontFamily: 'Grotesk',
                                              fontSize: 12),
                                        ),
                                        ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                                shadowColor: Colors.black,
                                                elevation: 0.5,
                                                backgroundColor: Colors.white,
                                                foregroundColor: Colors.black),
                                            onPressed: () {

                                              fireStoreProvider.addToCart(
                                                  CartItemModel(
                                                      name: document['name'],
                                                      price: document['price'],
                                                      imageUrl:
                                                          document['ImageUrl'],
                                                      size: document['Size'],
                                                      uid: document['uid']));

                                              snapshot
                                                  .data!.docs[index].reference
                                                  .delete();
                                              Fluttertoast.showToast(
                                                  msg: "Added to bag");
                                            },
                                            child: const Text("MOVE TO BAG")),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
