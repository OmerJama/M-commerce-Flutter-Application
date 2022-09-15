import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_app/models/cart_item_model.dart';
import 'package:mobile_app/providers/providers.dart';
import 'package:mobile_app/services/order_service.dart';
import 'package:mobile_app/view/ui/screens/user/home_screen.dart';

class UserBag extends ConsumerStatefulWidget {
  const UserBag({Key? key}) : super(key: key);

  @override
  ConsumerState<UserBag> createState() => _UserBagState();
}

final fkey = GlobalKey<FormState>();
TextEditingController addressController = TextEditingController();
TextEditingController postCodeController = TextEditingController();
TextEditingController countyController = TextEditingController();

class _UserBagState extends ConsumerState<UserBag> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Back button
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const Flexible(
                      child: Text(
                        "My Bag",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontFamily: 'Grotesk',
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                StreamBuilder(
                  stream: ref
                      .watch(firestoreProvider)!
                      .firestore
                      .collection("Carts")
                      .where(
                        'uid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid,
                      )
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
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
                              child: Lottie.asset("assets/anim/emptybox.json",
                                  width: 200, repeat: true),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              "Looks like your bag is empty!",
                              style: TextStyle(
                                  fontFamily: 'Grotesk',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20),
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
                        itemCount: snapshot.data!.docs.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final product = snapshot.data!.docs[index];
                          return Slidable(
                            endActionPane: ActionPane(
                                motion: const ScrollMotion(),
                                children: [
                                  SlidableAction(
                                    icon: Icons.delete,
                                    backgroundColor: Colors.red.shade700,
                                    onPressed: (context) async {
                                      await snapshot.data!.docs[index].reference
                                          .delete()
                                          .whenComplete(() {});
                                    },
                                  )
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: Colors.white,
                                ),
                                padding: const EdgeInsets.all(15),
                                height: 150,
                                width: double.infinity,
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(15),
                                      child: CachedNetworkImage(
                                        imageUrl: product['ImageUrl'],
                                        height: 200,
                                        width: 100,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            product['name'],
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontFamily: 'Grotesk',
                                                color: Colors.grey.shade600,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "£${product['price'].toStringAsFixed(2)}  |  ${product['Size']}",
                                            style: TextStyle(
                                                fontFamily: 'Grotesk',
                                                fontSize: 20,
                                                color: Colors.blue.shade600,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return const Center(child: Text(""));
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder(
                stream: ref
                    .watch(firestoreProvider)!
                    .firestore
                    .collection("Carts")
                    .where('uid',
                        isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    var ds = snapshot.data!.docs;
                    double sum = 0;
                    for (var i = 0; i < ds.length; i++) {
                      sum = sum + ds[i]['price'];
                    }
                    return Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                "Total: £${sum.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () async {
                                final paymentSheet =
                                    ref.read(paymentSheetProvider);
                                final fireStoreProvider =
                                    ref.watch(firestoreProvider);
                                if (sum != 0) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            color: Colors.white,
                                            child: ListView(
                                              shrinkWrap: true,
                                              children: [
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: const [
                                                    Text(
                                                      "Enter your delivery address",
                                                      style: TextStyle(
                                                          fontFamily: 'Grotesk',
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Form(
                                                    key: fkey,
                                                    child: Column(
                                                      children: [
                                                        addressField,
                                                        const Divider(),
                                                        postCodeField,
                                                        const Divider(),
                                                        countyField,
                                                      ],
                                                    )),
                                                const SizedBox(
                                                  height: 30,
                                                ),
                                                Text(
                                                  "Amount due: £${sum.toStringAsFixed(2)}",
                                                  style: const TextStyle(
                                                      fontFamily: 'Mula'),
                                                ),
                                                ElevatedButton(
                                                    onPressed: () async {
                                                      if (fkey.currentState!
                                                          .validate()) {
                                                        final response = await paymentSheet
                                                            .initPaymentSheet(
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .displayName,
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .email,
                                                                sum,
                                                                "${addressController.text}, ${postCodeController.text}, ${countyController.text}");

                                                        if (!response.isError) {
                                                          // ignore: use_build_context_synchronously
                                                          Fluttertoast.showToast(msg: "Payment completed");
                                                          OrderService
                                                              orderService =
                                                              OrderService();
                                                          var document =
                                                              snapshot
                                                                  .data!.docs;

                                                          List<CartItemModel>
                                                              cart = [];
                                                          for (int x = 0;
                                                              x <
                                                                  snapshot
                                                                      .data!
                                                                      .docs
                                                                      .length;
                                                              x++) {
                                                            cart.add(CartItemModel(
                                                                name: document[
                                                                    x]['name'],
                                                                price: document[
                                                                    x]['price'],
                                                                imageUrl: document[
                                                                        x][
                                                                    'ImageUrl'],
                                                                size: document[
                                                                    x]['Size'],
                                                                uid: document[x]
                                                                    ['uid']));
                                                          }
                                                          orderService.createOrder(
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .uid,
                                                              FirebaseAuth
                                                                  .instance
                                                                  .currentUser!
                                                                  .displayName!,
                                                              document[0]['id'],
                                                              cart,
                                                              sum,
                                                              "false",
                                                              "false",
                                                              "${addressController.text}, ${postCodeController.text}, ${countyController.text}",
                                                              "false");

                                                          //update stock for small
                                                          fireStoreProvider!
                                                              .firestore
                                                              .collection(
                                                                  "Products")
                                                              .get()
                                                              .then(
                                                                  (productSnapshot) {
                                                            fireStoreProvider
                                                                .firestore
                                                                .collection(
                                                                    "Carts")
                                                                .get()
                                                                .then(
                                                                    (cartSnapshot) {
                                                              final productSnapshotLength =
                                                                  productSnapshot
                                                                      .docs
                                                                      .length;
                                                              for (var p = 0;
                                                                  p < productSnapshotLength;
                                                                  p++) {
                                                                for (var y = 0;
                                                                    y <
                                                                        cartSnapshot
                                                                            .docs
                                                                            .length;
                                                                    y++) {
                                                                  //update small stock
                                                                  if (cartSnapshot.docs[y]['name'] == productSnapshot.docs[p]['name'] && cartSnapshot.docs[y]['Size'] ==
                                                                          'S' && productSnapshot.docs[p]['Small stock'] > 0) {
                                                                    int count = 0;
                                                                    for (var i =0;i < cartSnapshot.docs.length;i++) {
                                                                      if (cartSnapshot.docs[i]['Size'] == 'S' && cartSnapshot.docs[i]['name'] == cartSnapshot.docs[y]['name'] &&
                                                                      cartSnapshot.docs[i]['uid'] == FirebaseAuth.instance.currentUser!.uid) {
                                                                        count++;
                                                                      }
                                                                    }
                                                                    String id =productSnapshot.docs[p].id;
                                                                    int smallStock = productSnapshot.docs[p]['Small stock'];
                                                                    fireStoreProvider.firestore.collection("Products").doc(id).update({'Small stock':smallStock -count});
                                                                  }
                                                                  //update medium stock
                                                                  if (cartSnapshot.docs[y]
                                                                              [
                                                                              'name'] ==
                                                                          productSnapshot.docs[p]
                                                                              [
                                                                              'name'] &&
                                                                      cartSnapshot.docs[y]
                                                                              [
                                                                              'Size'] ==
                                                                          'M' &&
                                                                      productSnapshot.docs[p]
                                                                              [
                                                                              'Medium stock'] >
                                                                          0) {
                                                                    int count =
                                                                        0;
                                                                    for (var i =
                                                                            0;
                                                                        i < cartSnapshot.docs.length;
                                                                        i++) {
                                                                      if (cartSnapshot.docs[i]['Size'] ==
                                                                              'M' &&
                                                                          cartSnapshot.docs[i]['name'] ==
                                                                              cartSnapshot.docs[y]['name'] &&  cartSnapshot.docs[i]['uid'] == FirebaseAuth.instance.currentUser!.uid) {
                                                                        count++;
                                                                      }
                                                                    }
                                                                    String id =
                                                                        productSnapshot
                                                                            .docs[p]
                                                                            .id;
                                                                    int mediumStock =
                                                                        productSnapshot.docs[p]
                                                                            [
                                                                            'Medium stock'];
                                                                    fireStoreProvider
                                                                        .firestore
                                                                        .collection(
                                                                            "Products")
                                                                        .doc(id)
                                                                        .update({
                                                                      'Medium stock':
                                                                          mediumStock -
                                                                              count
                                                                    });
                                                                  }
                                                                  //update large stock
                                                                  if (cartSnapshot.docs[y]
                                                                              [
                                                                              'name'] ==
                                                                          productSnapshot.docs[p]
                                                                              [
                                                                              'name'] &&
                                                                      cartSnapshot.docs[y]
                                                                              [
                                                                              'Size'] ==
                                                                          'L' &&
                                                                      productSnapshot.docs[p]
                                                                              [
                                                                              'Large stock'] >
                                                                          0) {
                                                                    int count =
                                                                        0;
                                                                    for (var i =
                                                                            0;
                                                                        i < cartSnapshot.docs.length;
                                                                        i++) {
                                                                      if (cartSnapshot.docs[i]['Size'] ==
                                                                              'L' &&
                                                                          cartSnapshot.docs[i]['name'] ==
                                                                              cartSnapshot.docs[y]['name'] &&  cartSnapshot.docs[i]['uid'] == FirebaseAuth.instance.currentUser!.uid) {
                                                                        count++;
                                                                      }
                                                                    }
                                                                    String id =
                                                                        productSnapshot
                                                                            .docs[p]
                                                                            .id;
                                                                    int largeStock =
                                                                        productSnapshot.docs[p]
                                                                            [
                                                                            'Large stock'];
                                                                    fireStoreProvider
                                                                        .firestore
                                                                        .collection(
                                                                            "Products")
                                                                        .doc(id)
                                                                        .update({
                                                                      'Large stock':
                                                                          largeStock -
                                                                              count
                                                                    });
                                                                  }
                                                                  //update xl stock
                                                                  if (cartSnapshot.docs[y]
                                                                              [
                                                                              'name'] ==
                                                                          productSnapshot.docs[p]
                                                                              [
                                                                              'name'] &&
                                                                      cartSnapshot.docs[y]
                                                                              [
                                                                              'Size'] ==
                                                                          'XL' &&
                                                                      productSnapshot.docs[p]
                                                                              [
                                                                              'X Large stock'] >
                                                                          0) {
                                                                    int count =
                                                                        0;
                                                                    for (var i =
                                                                            0;
                                                                        i < cartSnapshot.docs.length;
                                                                        i++) {
                                                                      if (cartSnapshot.docs[i]['Size'] ==
                                                                              'XL' &&
                                                                          cartSnapshot.docs[i]['name'] ==
                                                                              cartSnapshot.docs[y]['name'] &&  cartSnapshot.docs[i]['uid'] == FirebaseAuth.instance.currentUser!.uid) {
                                                                        count++;
                                                                      }
                                                                    }
                                                                    String id =
                                                                        productSnapshot
                                                                            .docs[p]
                                                                            .id;
                                                                    int xLargeStock =
                                                                        productSnapshot.docs[p]
                                                                            [
                                                                            'X Large stock'];
                                                                    int stock =
                                                                        productSnapshot.docs[p]
                                                                            [
                                                                            'Stock'];
                                                                    fireStoreProvider
                                                                        .firestore
                                                                        .collection(
                                                                            "Products")
                                                                        .doc(id)
                                                                        .update({
                                                                      'X Large stock':
                                                                          xLargeStock -
                                                                              count,
                                                                      'Stock':
                                                                          stock -
                                                                              count,
                                                                    }).whenComplete(
                                                                            () {});
                                                                  }
                                                                }
                                                              }
                                                            }).whenComplete(() {
                                                              fireStoreProvider
                                                                  .firestore
                                                                  .collection(
                                                                      "Carts")
                                                                  .where("uid",
                                                                      isEqualTo: FirebaseAuth
                                                                          .instance
                                                                          .currentUser!
                                                                          .uid)
                                                                  .get()
                                                                  .then(
                                                                      (value) {
                                                                for (DocumentSnapshot ds
                                                                    in value
                                                                        .docs) {
                                                                  ds.reference
                                                                      .delete();
                                                                }
                                                              }).whenComplete(
                                                                      () {
                                                                Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => const HomeScreen(),), (route) => false);
                                                              });
                                                            });
                                                          });
                                                        } else {
                                                          // ignore: use_build_context_synchronously
                                                          Fluttertoast.showToast(msg: response.message);
                                                          
                                                         
                                                        }
                                                      }
                                                    },
                                                    child: const Text(
                                                        "Confirm order"))
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }
                              },
                              child: const Text("Checkout"),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return const Text("");
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  final addressField = TextFormField(
    key: Key(FirebaseAuth.instance.currentUser!.uid),
    controller: addressController,
    autofocus: false,
    textCapitalization: TextCapitalization.sentences,
    keyboardType: TextInputType.streetAddress,
    validator: (address) {
      if (address!.isEmpty) {
        return "Please enter your address";
      }

     
      return null;
    },
    onSaved: (newValue) {
      addressController.text = newValue!;
    },
    decoration: InputDecoration(
        prefixIcon: const Icon(Icons.house),
        hintText: "Delivery address",
        contentPadding: const EdgeInsets.all(20),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey.shade50),
    textInputAction: TextInputAction.next,
  );

  final postCodeField = TextFormField(
    controller: postCodeController,
    autofocus: false,
    textCapitalization: TextCapitalization.sentences,
    validator: (postcode) {
      if (postcode!.isEmpty) {
        return "Please enter postcode";
      }
      if (!RegExp(
              r'([Gg][Ii][Rr] 0[Aa]{2})|((([A-Za-z][0-9]{1,2})|(([A-Za-z][A-Ha-hJ-Yj-y][0-9]{1,2})|(([A-Za-z][0-9][A-Za-z])|([A-Za-z][A-Ha-hJ-Yj-y][0-9][A-Za-z]?))))\s?[0-9][A-Za-z]{2})')
          .hasMatch(postcode)) {
        return "Please enter a valid postcode";
      }
      return null;
    },
    onSaved: (newValue) {
      postCodeController.text = newValue!;
    },
    decoration: InputDecoration(
        prefixIcon: const Icon(Icons.house),
        hintText: "Postcode",
        contentPadding: const EdgeInsets.all(20),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey.shade50),
    textInputAction: TextInputAction.next,
  );

  final countyField = TextFormField(
    controller: countyController,
    autofocus: false,
    textCapitalization: TextCapitalization.sentences,
    keyboardType: TextInputType.name,
    validator: (county) {
      if (county!.isEmpty) {
        return "Please enter your county";
      }
      if (county.trim().length < 4) {
        return "Please enter a valid county name";
      }
      return null;
    },
    onSaved: (newValue) {
      countyController.text = newValue!;
    },
    decoration: InputDecoration(
        prefixIcon: const Icon(Icons.house),
        hintText: "County",
        contentPadding: const EdgeInsets.all(20),
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.grey.shade50),
    textInputAction: TextInputAction.done,
  );
}
