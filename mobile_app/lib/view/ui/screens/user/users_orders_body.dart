import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_app/providers/providers.dart';

class UserOrderBody extends ConsumerStatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final dropdownValue;
  const UserOrderBody({
    required this.dropdownValue,
    Key? key}) : super(key: key);

  @override
  ConsumerState<UserOrderBody> createState() => _UserOrderBodyState();
}
class _UserOrderBodyState extends ConsumerState<UserOrderBody> {
  @override
  Widget build(BuildContext context) {
    final fireStoreProvider = ref.read(firestoreProvider);
   if (widget.dropdownValue == "All orders") {
      return StreamBuilder(
        stream: fireStoreProvider!.getOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       SizedBox(height: MediaQuery.of(context).size.height/6,),
                       const Text("No orders yet!"),
                       const SizedBox(height: 10,),
                      Center(
                        child: Lottie.asset("assets/anim/emptybox.json",
                            width: 200, repeat: true),
                      ),
                    ],
                  );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                final timeStamp = snapshot.data![index].optionalid;

                final total = order.product
                    .map(((e) => e.price))
                    .reduce((value, element) => value + element);
                return GestureDetector(
                  onTap: () =>  showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                StreamBuilder(
                                  stream: fireStoreProvider.firestore
                                      .collection("Orders")
                                      .where('id', isEqualTo: timeStamp)
                                      .snapshots(),
                                  builder: (context, snapshotTwo) {
                                    if (snapshotTwo.hasData) {
                                      var document = snapshotTwo.data!.docs[0];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                             Text("Delivery address: ${document['deliveryaddress']} "),
                                             const SizedBox(height: 30,),
                                            ElevatedButton(onPressed: () {
                                              showDialog(context: context, builder: (context) {
                                                return AlertDialog(
                                                  title: const Text("Are you sure you want to cancel this order?"),
                                                  actions: [
                                                    ElevatedButton(onPressed: () {
                                                      document.reference.update({
                                                        "cancelled" : "true",
                                                      }).whenComplete(() {
                                                        Navigator.pop(context);
                                                        Navigator.pop(context);
                                                        Fluttertoast.showToast(msg: "Order cancelled");
                                                      });
                                                    }, child: const Text("Yes")),
                                                    ElevatedButton(onPressed: () {
                                                      Navigator.pop(context);
                                                      Navigator.pop(context);
                                                    }, child: const Text("No")),
                                                  ],
                                                );
                                              },);
                                            }, child: const Text("Cancel order"))
                                          ],
                                        ),
                                      );
                                    }
                                    return const Text("");
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.white,
                      title: Text(order.product.map((e) => e.name,).join(', ')),
                      subtitle: Text(("Size: ${order.product.map((e) => e.size).join(' ')}\n${order.timestamp.toDate()}")),
                      trailing: Text("£${total.toStringAsFixed(2)}"),
                    ),
                  ),
                );
              },
            );
          }
          return const Text("");
        },
      );
    }
    if (widget.dropdownValue == "Shipped orders") {
      return StreamBuilder(
        stream: fireStoreProvider!.getAllShippedUserOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       SizedBox(height: MediaQuery.of(context).size.height/6,),
                       const Text("No orders shipped yet!"),
                       const SizedBox(height: 10,),
                      Center(
                        child: Lottie.asset("assets/anim/emptybox.json",
                            width: 200, repeat: true),
                      ),
                    ],
                  );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                final timeStamp = snapshot.data![index].optionalid;

                final total = order.product
                    .map(((e) => e.price))
                    .reduce((value, element) => value + element);
                return GestureDetector(
                  onTap: () =>  showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                StreamBuilder(
                                  stream: fireStoreProvider.firestore
                                      .collection("Orders")
                                      .where('id', isEqualTo: timeStamp)
                                      .snapshots(),
                                  builder: (context, snapshotTwo) {
                                    if (snapshotTwo.hasData) {
                                      var document = snapshotTwo.data!.docs[0];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                             Text("Delivery address: ${document['deliveryaddress']} "),
                                             const SizedBox(height: 30,),
                                            
                                          ],
                                        ),
                                      );
                                    }
                                    return const Text("");
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.white,
                      title: Text(order.product.map((e) => e.name,).join(', ')),
                      subtitle: Text(("Size: ${order.product.map((e) => e.size).join(' ')}\n${order.timestamp.toDate()}")),
                      trailing: Text("£${total.toStringAsFixed(2)}"),
                    ),
                  ),
                );
              },
            );
          }
          return const Text("sdfdsf");
        },
      );
    }
    if (widget.dropdownValue == "Delivered orders") {
      return StreamBuilder(
        stream: fireStoreProvider!.getAllDeliveredUserOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       SizedBox(height: MediaQuery.of(context).size.height/6,),
                       const Text("No orders delivered yet!"),
                       const SizedBox(height: 10,),
                      Center(
                        child: Lottie.asset("assets/anim/emptybox.json",
                            width: 200, repeat: true),
                      ),
                    ],
                  );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                final timeStamp = snapshot.data![index].optionalid;

                final total = order.product
                    .map(((e) => e.price))
                    .reduce((value, element) => value + element);
                return GestureDetector(
                  onTap: () =>  showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                StreamBuilder(
                                  stream: fireStoreProvider.firestore
                                      .collection("Orders")
                                      .where('id', isEqualTo: timeStamp)
                                      .snapshots(),
                                  builder: (context, snapshotTwo) {
                                    if (snapshotTwo.hasData) {
                                      var document = snapshotTwo.data!.docs[0];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                             Text("Delivery address: ${document['deliveryaddress']} "),
                                             const SizedBox(height: 30,),
                                            
                                          ],
                                        ),
                                      );
                                    }
                                    return const Text("");
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.white,
                      title: Text(order.product.map((e) => e.name,).join(', ')),
                      subtitle: Text(("Size: ${order.product.map((e) => e.size).join(' ')}\n${order.timestamp.toDate()}")),
                      trailing: Text("£${total.toStringAsFixed(2)}"),
                    ),
                  ),
                );
              },
            );
          }
          return const Text("");
        },
      );
    }
    if (widget.dropdownValue == "Cancelled orders") {
      return StreamBuilder(
        stream: fireStoreProvider!.getAllCancelledUserOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!.isEmpty) {
              return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       SizedBox(height: MediaQuery.of(context).size.height/6,),
                       const Text("Phew! No cancellations."),
                       const SizedBox(height: 10,),
                      Center(
                        child: Lottie.asset("assets/anim/emptybox.json",
                            width: 200, repeat: true),
                      ),
                    ],
                  );
            }
            return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final order = snapshot.data![index];
                final timeStamp = snapshot.data![index].optionalid;

                final total = order.product
                    .map(((e) => e.price))
                    .reduce((value, element) => value + element);
                return GestureDetector(
                  onTap: () =>  showDialog(
                        context: context,
                        builder: (context) {
                          return Dialog(
                            child: ListView(
                              shrinkWrap: true,
                              children: [
                                StreamBuilder(
                                  stream: fireStoreProvider.firestore
                                      .collection("Orders")
                                      .where('id', isEqualTo: timeStamp)
                                      .snapshots(),
                                  builder: (context, snapshotTwo) {
                                    if (snapshotTwo.hasData) {
                                      var document = snapshotTwo.data!.docs[0];
                                      return Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          children: [
                                             Text("Delivery address: ${document['deliveryaddress']} "),
                                             const SizedBox(height: 30,),
                                            
                                          ],
                                        ),
                                      );
                                    }
                                    return const Text("");
                                  },
                                )
                              ],
                            ),
                          );
                        },
                      ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      tileColor: Colors.white,
                      title: Text(order.product.map((e) => e.name,).join(', ')),
                      subtitle: Text(("Size: ${order.product.map((e) => e.size).join(' ')}\n${order.timestamp.toDate()}")),
                      trailing: Text("£${total.toStringAsFixed(2)}"),
                    ),
                  ),
                );
              },
            );
          }
          return const Text("");
        },
      );
    }
    return Container();
  }
  }
