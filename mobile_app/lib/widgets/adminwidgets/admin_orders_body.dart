import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/providers/providers.dart';

class AdminOrderDisplayBody extends ConsumerStatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final dropdownValue;
  const AdminOrderDisplayBody({required this.dropdownValue, Key? key})
      : super(key: key);

  @override
  ConsumerState<AdminOrderDisplayBody> createState() =>
      _AdminOrderDisplayBodyState();
}

class _AdminOrderDisplayBodyState extends ConsumerState<AdminOrderDisplayBody> {
  @override
  Widget build(BuildContext context) {
    final fireStoreProvider = ref.read(firestoreProvider);

    if (widget.dropdownValue == "All orders") {
      return StreamBuilder(
        stream: fireStoreProvider!.getAllOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
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
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          children: [
                                             Text("Delivery address: ${document['deliveryaddress']} "),
                                            const SizedBox(height: 30,),
                                            ListView(
                                              shrinkWrap: true,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      document.reference.update({
                                                        "shipped": "true",
                                                      }).whenComplete(() =>
                                                          Navigator.pop(context));
                                                    },
                                                    child: const Text("Shipped")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      document.reference.update({
                                                        "delivered": "true",
                                                      }).whenComplete(() =>
                                                          Navigator.pop(context));
                                                    },
                                                    child:
                                                        const Text("Delivered")),
                                              ],
                                            ),
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
                      );
                    },
                    child: ListTile(
                      tileColor: Colors.white,
                      title: Text(order.product.map((e) => e.name,).join(', ')),
                      subtitle: Text(("Ordered by: ${order.name}\nSize: ${order.product.map((e) => e.size).join(' ')}\n${order.timestamp.toDate()}")),
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
        stream: fireStoreProvider!.getShippedOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
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
                                            Text("Delivery address: ${document['deliveryaddress']}"),
                                            const SizedBox(height: 30,),
                                            ListView(
                                              shrinkWrap: true,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      document.reference.update({
                                                        "shipped": "false",
                                                      }).whenComplete(() =>
                                                          Navigator.pop(context));
                                                    },
                                                    child: const Text(
                                                        "Cancel shipment")),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      document.reference.update({
                                                        "shipped": "false",
                                                        "delivered": "true",
                                                      }).whenComplete(() =>
                                                          Navigator.pop(context));
                                                    },
                                                    child:
                                                        const Text("Delivered")),
                                              ],
                                            ),
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
                      );
                    },
                    child: ListTile(
                      tileColor: Colors.white,
                      title: Text(order.product.map((e) => e.name,).join(', ')),
                      subtitle: Text(("Ordered by: ${order.name}\nSize: ${order.product.map((e) => e.size).join(' ')}\n${order.timestamp.toDate()}")),
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
        stream: fireStoreProvider!.getDeliveredOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
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
                                            ListView(
                                              shrinkWrap: true,
                                              children: [
                                                ElevatedButton(
                                                    onPressed: () {
                                                      document.reference.update({
                                                        "delivered": "remove",
                                                        "shipped": "false",
                                                      }).whenComplete(() =>
                                                          Navigator.pop(context));
                                                    },
                                                    child: const Text(
                                                        "Remove from delivered list")),
                                                 ElevatedButton(
                                                    onPressed: () {
                                                      document.reference.update({
                                                        "cancelled": "true",
                                                        "delivered" : "false",
                                                        "shipped" : "false",
                                                      }).whenComplete(() =>
                                                          Navigator.pop(context));
                                                    },
                                                    child: const Text(
                                                        "Order cancelled")),       
                                              ],
                                            ),
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
                      );
                    },
                    child:  ListTile(
                      tileColor: Colors.white,
                      title: Text(order.product.map((e) => e.name,).join(', ')),
                      subtitle: Text(("Ordered by: ${order.name}\nSize: ${order.product.map((e) => e.size).join(' ')}\n${order.timestamp.toDate()}")),
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
        stream: fireStoreProvider!.getAllCancelledOrders(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
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
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
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
                                            ListView(
                                              shrinkWrap: true,
                                              children: const [
                                                    
                                              ],
                                            ),
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
                      );
                    },
                    child:  ListTile(
                      tileColor: Colors.white,
                      title: Text(order.product.map((e) => e.name,).join(', ')),
                      subtitle: Text(("Ordered by: ${order.name}\nSize: ${order.product.map((e) => e.size).join(' ')}\n${order.timestamp.toDate()}")),
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
