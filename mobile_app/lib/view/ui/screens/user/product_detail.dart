import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/view/ui/screens/admin/add_product_screen.dart';
import 'package:mobile_app/view/ui/screens/admin/viewedit_category.dart';
import 'package:mobile_app/view/ui/screens/user/user_bags_screen.dart';
import 'package:mobile_app/view/ui/screens/user/wishlist_screen.dart';
import 'package:mobile_app/models/cart_item_model.dart';

import 'package:mobile_app/models/wishlist_model.dart';
import 'package:mobile_app/providers/providers.dart';

class ProductDetail extends ConsumerStatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> product;
  final String documentId;
  const ProductDetail(
      {required this.product, required this.documentId, Key? key})
      : super(key: key);

  @override
  ConsumerState<ProductDetail> createState() => _ProductDetailState();
}

// ignore: prefer_typing_uninitialized_variables
var dropdownValue;
bool addedToFavourites = false;
bool wishListExists = false;

class _ProductDetailState extends ConsumerState<ProductDetail> {
  @override
  Widget build(BuildContext context) {
    final fireStoreProvider = ref.read(firestoreProvider);

    return WillPopScope(
      onWillPop: () async {
        
        setState(() {
          dropdownValue = null;
          dropdownValue = null;
        });
        
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                dropdownValue = null;
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_sharp)),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Hero(
                  tag: widget.product['name'],
                  child: ClipRRect(
                      child: CachedNetworkImage(
                    imageUrl: widget.product['ImageUrl'],
                    fit: BoxFit.fill,
                    height: MediaQuery.of(context).size.height / 1.9,
                    width: MediaQuery.of(context).size.width,
                  )),
                ),
                const SizedBox(
                  height: 15,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 8, right: 8),
                  child: Text(
                    widget.product['name'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: Colors.black,
                        fontFamily: 'Grotesk',
                        fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, bottom: 8, right: 8),
                  child: Text(
                    // ignore: prefer_interpolation_to_compose_strings, unnecessary_string_escapes
                    "\£" + widget.product['price'].toStringAsFixed(2),
                    style: const TextStyle(
                        color: Colors.black, fontFamily: 'Mula', fontSize: 15),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15, top: 8),
                  child: Divider(
                    color: Colors.grey.shade400,
                    height: 20,
                  ),
                ),
                StreamBuilder(
                  stream: fireStoreProvider!.firestore
                      .collection("Products")
                      .where('id', isEqualTo: widget.product['id'])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 15, right: 180),
                        child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            final document = snapshot.data!.docs[index];
                            List<String> sizesList =
                                document['Sizes'].split(',');
                            sortSizes(sizesList);
                            //Dont display if stock is 0
                            if (document['Small stock'] <= 0) {
                              if (sizesList.contains("S")) {
                                sizesList.remove("S");
                              }
                            }
                            if (document['Medium stock'] <= 0) {
                              if (sizesList.contains("M")) {
                                sizesList.remove("M");
                              }
                            }
                            if (document['Large stock'] <= 0) {
                              if (sizesList.contains("L")) {
                                sizesList.remove("L");
                              }
                            }
                            if (document['X Large stock'] <= 0) {
                              if (sizesList.contains("XL")) {
                                sizesList.remove("XL");
                              }
                            }

                            return DropdownButtonHideUnderline(
                              child: DropdownButton(
                                isExpanded: true,
                                hint: const Text("Select available size"),
                                value: dropdownValue,
                                items: sizesList.map<DropdownMenuItem<String>>(
                                    (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    dropdownValue = value!;
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      );
                    }
                    return Container();
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Consumer(
                    builder: (context, ref, child) {
                      if (widget.product['Small stock'] <= 0 &&
                          widget.product['Medium stock'] <= 0 &&
                          widget.product['Large stock'] <= 0 &&
                          widget.product['X Large stock'] <= 0) {
                        return const Text("Out of stock");
                      }

                      return const Text("");
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(left: 15, bottom: 8, right: 8),
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue.shade700,
                              minimumSize: Size(
                                  MediaQuery.of(context).size.width / 1.5, 50)),
                          onPressed: () {
                            if (dropdownValue == null) {
                              Fluttertoast.showToast(
                                  msg: "Pick a size before adding to bag");
                              return;
                            }
                            // ref.read(userBagProvider).addProduct(CartItemModel(name: widget.product['name'], price: widget.product['price'], imageUrl: widget.product['ImageUrl'], size: dropdownValue, uid: FirebaseAuth.instance.currentUser!.uid));
                            fireStoreProvider.addToCart(CartItemModel(
                                name: widget.product['name'],
                                price: widget.product['price'],
                                imageUrl: widget.product['ImageUrl'],
                                size: dropdownValue,
                                uid: FirebaseAuth.instance.currentUser!.uid));

                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const UserBag()));
                            setState(() {
                              dropdownValue = null;
                            });
                          },
                          child: const Text(
                            "ADD TO BAG",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Grotesk',
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    const SizedBox(
                      height: 0,
                      width: 20,
                    ),
                    Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade300,
                        shape: BoxShape.circle,
                      ),
                      child: IconButton(
                          onPressed: () async {
                            final storage = ref.read(firestoreProvider);
                            final fileStorage = ref.read(storageProvider);
                            final authentication = FirebaseAuth.instance;

                            if (storage == null ||
                                // ignore: unnecessary_null_comparison
                                imageProvider == null ||
                                fileStorage == null) {
                              // ignore: avoid_print
                              print("Storages are null");
                              return;
                            }
                            if (dropdownValue == null) {
                              Fluttertoast.showToast(
                                  msg:
                                      "Select a size before you add to wishlist");
                              return;
                            }

                            await storage
                                .addToWishlist(Wishlist(
                                    name: widget.product['name'],
                                    description: widget.product['description'],
                                    price: widget.product['price'],
                                    imageUrl: widget.product['ImageUrl'],
                                    size: dropdownValue,
                                    uid: authentication.currentUser!.uid))
                                // ignore: void_checks
                                .whenComplete(() {
                              Navigator.pushReplacement(context, MaterialPageRoute(
                                builder: (context) {
                                  return const WishlistScreen();
                                },
                              ));
                              setState(() {
                              dropdownValue = null;
                            });
                              return Fluttertoast.showToast(
                                  msg: "Product added to wishlist");
                            });
                          },
                          icon: const Icon(Icons.favorite_outline)),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    height: 180,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      border:
                          Border.all(color: Colors.grey.shade400, width: 0.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Icon(Icons.local_shipping_outlined),
                            SizedBox(
                              width: 15,
                              height: 0,
                            ),
                            Text(
                              "Delivery fee included in price",
                              style: TextStyle(fontFamily: 'Grotesk'),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: const [
                            Icon(Icons.assignment_return_outlined),
                            SizedBox(
                              height: 0,
                              width: 15,
                            ),
                            Text(
                              "For returns, contact customer service",
                              style: TextStyle(fontFamily: 'Grotesk'),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        const Text(
                          "Terms and conditions apply",
                          style: TextStyle(fontFamily: 'Grotesk'),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ExpansionTile(
                  initiallyExpanded: false,
                  title: const Text(
                    "Product details",
                    style: TextStyle(
                        fontFamily: 'Grotesk', fontWeight: FontWeight.bold),
                  ),
                  children: [
                    ListTile(
                      title: Text(
                        widget.product['description'],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  sortSizes(List sizesList) {
    if (sizesList.contains("S")) {
      sizesList.remove("S");
      sizesList.insert(0, "S");
    }
    if (sizesList.contains("M") && sizesList.contains("S")) {
      sizesList.remove("M");
      sizesList.insert(1, "M");
    } else if (sizesList.contains("M") && !sizesList.contains("S")) {
      sizesList.remove("M");
      sizesList.insert(0, "M");
    }
    if (sizesList.contains("L") &&
        sizesList.contains("S") &&
        sizesList.contains("M")) {
      sizesList.remove("L");
      sizesList.insert(2, "L");
    } else if (sizesList.contains("L") &&
        !sizesList.contains("S") &&
        !sizesList.contains("M")) {
      sizesList.remove("L");
      sizesList.insert(0, "L");
    } else if (sizesList.contains("L") &&
        !sizesList.contains("S") &&
        sizesList.contains("M")) {
      sizesList.remove("L");
      sizesList.insert(1, "L");
    }
    if (selectedSizes.contains("XL") &&
        selectedSizes.contains("S") &&
        selectedSizes.contains("M") &&
        selectedSizes.contains("XL") &&
        selectedSizes.indexOf("XL") != 3) {
      selectedSizes.remove("XL");
      selectedSizes.insert(3, "XL");
    } else if (selectedSizes.contains("XL") &&
        !sizesList.contains("S") &&
        sizesList.contains("M") &&
        !sizesList.contains("L")) {
      sizesList.remove("XL");
      sizesList.insert(1, "XL");
    } else if (selectedSizes.contains("XL") &&
        sizesList.contains("S") &&
        sizesList.contains("M") &&
        !sizesList.contains("L")) {
      sizesList.remove("XL");
      sizesList.insert(2, "XL");
    } else if (selectedSizes.contains("XL") &&
        !sizesList.contains("S") &&
        sizesList.contains("M") &&
        sizesList.contains("L")) {
      sizesList.remove("XL");
      sizesList.insert(2, "XL");
    }
  }
}
