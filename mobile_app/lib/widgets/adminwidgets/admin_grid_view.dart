import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/view/ui/screens/admin/admin_display_orders.dart';
import 'package:mobile_app/view/ui/screens/admin/admin_users_screen.dart';
import 'package:mobile_app/view/ui/screens/admin/viewedit_category.dart';
import 'package:mobile_app/view/ui/screens/admin/viewedit_products.dart';

class AdminGridView extends StatelessWidget {
  const AdminGridView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize = 13;
    return Expanded(
        child: GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
      ),
      children: [
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDisplayOrders(),)),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Card(
              child: ListTile(
                title: TextButton.icon(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDisplayOrders(),));},
                    icon: const Icon(
                      Icons.shopping_cart_rounded,
                      color: Colors.black,
                    ),
                    label:  Text(
                      "Orders",
                      style: TextStyle(color: Colors.black, fontSize: fontSize),
                    )),
                subtitle: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Orders")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return const Text(
                          "0",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 42,
                              fontFamily: 'Mula'),
                        );
                      }
                      return Text(
                        snapshot.data!.docs.length.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 42,
                            fontFamily: 'Mula'),
                      );
                    }
                    return const Text("");
                  },
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDisplayOrders(),)),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Card(
              child: ListTile(
                title: TextButton.icon(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDisplayOrders(),));},
                    icon: const Icon(
                      Icons.timelapse,
                      color: Colors.black,
                    ),
                    label:  Text(
                      "Waiting",
                      style: TextStyle(color: Colors.black, fontSize: fontSize),
                    )),
                subtitle: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Orders").where("shipped", isEqualTo: "false").where("cancelled", isEqualTo: "false").where("delivered", isEqualTo: "false")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return const Text(
                          "0",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 42,
                              fontFamily: 'Mula'),
                        );
                      }
                      return Text(
                        snapshot.data!.docs.length.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 42,
                            fontFamily: 'Mula'),
                      );
                    }
                    return const Text("");
                  },
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoriesViewEdit(),)),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Card(
              child: ListTile(
                title: TextButton.icon(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const CategoriesViewEdit(),));},
                    icon: const Icon(
                      Icons.category,
                      color: Colors.black,
                    ),
                    label:  Text(
                      "Categories",
                      style: TextStyle(color: Colors.black, fontSize: fontSize),
                    )),
                subtitle: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Categories")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return const Text(
                          "0",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 42,
                              fontFamily: 'Mula'),
                        );
                      }
                      return Text(
                        snapshot.data!.docs.length.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 42,
                            fontFamily: 'Mula'),
                      );
                    }
                    return const Text("");
                  },
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductsViewEdit(),)),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Card(
              child: ListTile(
                title: TextButton.icon(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductsViewEdit(),));},
                    icon: const Icon(
                      Icons.list,
                      color: Colors.black,
                    ),
                    label:  Text(
                      "Products",
                      style: TextStyle(color: Colors.black, fontSize: fontSize),
                    )),
                subtitle: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Products")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return const Text(
                          "0",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 42,
                              fontFamily: 'Mula'),
                        );
                      }
                      return Text(
                        snapshot.data!.docs.length.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 42,
                            fontFamily: 'Mula'),
                      );
                    }
                    return const Text("");
                  },
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewUsersScreen(),)),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Card(
              child: ListTile(
                title: TextButton.icon(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const ViewUsersScreen(),));},
                    icon: const Icon(
                      Icons.people,
                      color: Colors.black,
                    ),
                    label:  Text(
                      "Users",
                      style: TextStyle(color: Colors.black, fontSize: fontSize),
                    )),
                subtitle: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return const Text(
                          "0",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 42,
                              fontFamily: 'Mula'),
                        );
                      }
                      return Text(
                        snapshot.data!.docs.length.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 42,
                            fontFamily: 'Mula'),
                      );
                    }
                    return const Text("");
                  },
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDisplayOrders(),)),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Card(
              child: ListTile(
                title: TextButton.icon(
                    onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => const AdminDisplayOrders(),));},
                    icon: const Icon(
                      Icons.cancel,
                      color: Colors.black,
                    ),
                    label:  Text(
                      "Cancelled",
                      style: TextStyle(color: Colors.black, fontSize: fontSize),
                    )),
                subtitle: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("Orders").where("cancelled", isEqualTo: "true")
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data!.docs.isEmpty) {
                        return const Text(
                          "0",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 42,
                              fontFamily: 'Mula'),
                        );
                      }
                      return Text(
                        snapshot.data!.docs.length.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.blue,
                            fontSize: 42,
                            fontFamily: 'Mula'),
                      );
                    }
                    return const Text("");
                  },
                ),
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
