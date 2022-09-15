import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/view/ui/screens/admin/add_category_screen.dart';
import 'package:mobile_app/view/ui/screens/admin/add_product_screen.dart';
import 'package:mobile_app/view/ui/screens/admin/admin_display_orders.dart';
import 'package:mobile_app/view/ui/screens/admin/admin_faq_edit.dart';
import 'package:mobile_app/view/ui/screens/admin/admin_guide_screen.dart';
import 'package:mobile_app/view/ui/screens/admin/admin_home_screen.dart';
import 'package:mobile_app/view/ui/screens/admin/admin_low_stock.dart';
import 'package:mobile_app/services/firestore_service.dart';
import 'package:mobile_app/view/ui/screens/admin/viewedit_category.dart';
import 'package:mobile_app/view/ui/screens/admin/viewedit_products.dart';
import 'package:mobile_app/widgets/adminwidgets/admin_grid_view.dart';
import 'package:mobile_app/widgets/adminwidgets/manage_tile.dart';

class BodyScreen extends StatelessWidget {
  final Pages selectedPage;
  final Pages page;
  final TextStyle textStyle;
  final FirestoreService? firestoreService;
  const BodyScreen({
    Key? key,
    required this.selectedPage,
    required this.page,
    required this.textStyle,
    this.firestoreService,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (selectedPage == page) {
      return Column(
        children: [
          const SizedBox(height: 5),
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection("Orders").where('cancelled',isEqualTo: "false").snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.docs.isEmpty) {
                  return const Text("Revenue: £0.00", style: TextStyle(
                      fontFamily: 'Mula', color: Colors.blue, fontSize: 25), );
                }
                var document = snapshot.data!.docs;
                double sum = 0;
                for (int x = 0; x < snapshot.data!.docs.length; x++) {
                  sum = sum + document[x]['totalprice'];
                }
                return Text(
                  "Revenue\n £${sum.toStringAsFixed(2)}",
                  style: const TextStyle(
                      fontFamily: 'Mula', color: Colors.blue, fontSize: 25),
                );
              }

              return const Text("");
            },
          ),
          const AdminGridView()
        ],
      );
    }
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
      child: ListView(
        children: [
          ManageTile(
            title: "Orders",
            style: textStyle,
            color: Colors.blue,
            icon: const Icon(Icons.list, color: Colors.blue),
            tileColor: Colors.white,
            screen: const AdminDisplayOrders(),
          ),
          const Divider(),
          ManageTile(
            title: "Add category",
            style: textStyle,
            color: Colors.blue,
            icon: const Icon(Icons.category, color: Colors.blue),
            tileColor: Colors.white,
            screen: const AddCategoryScreen(),
          ),
          const Divider(),
          ManageTile(
            title: "View and edit categories",
            style: textStyle,
            color: Colors.blue,
            icon: const Icon(Icons.remove_red_eye, color: Colors.blue),
            tileColor: Colors.white,
            screen: const CategoriesViewEdit(),
          ),
          const Divider(),
          ManageTile(
            title: "Add a product",
            style: textStyle,
            color: Colors.blue,
            icon: const Icon(
              Icons.add,
              color: Colors.blue,
            ),
            tileColor: Colors.white,
            screen: const AddProductScreen(),
          ),
          const Divider(),
          ManageTile(
            title: "View and edit products",
            style: textStyle,
            color: Colors.blue,
            icon: const Icon(
              Icons.remove_red_eye,
              color: Colors.blue,
            ),
            tileColor: Colors.white,
            screen: const ProductsViewEdit(),
          ),
          const Divider(),
          ManageTile(
            title: "Edit FAQs",
            style: textStyle,
            color: Colors.blue,
            icon: const Icon(Icons.edit, color: Colors.blue),
            tileColor: Colors.white,
            screen: const EditFaqScreen(),
          ),
          const Divider(),
          ManageTile(
            title: "Low stock",
            style: textStyle,
            color: Colors.blue,
            icon: const Icon(Icons.hourglass_empty, color: Colors.blue),
            tileColor: Colors.white,
            screen: const LowStockScreen(),
          ),
          const Divider(),
          ManageTile(
            title: "Guide",
            style: textStyle,
            color: Colors.blue,
            icon: const Icon(Icons.help, color: Colors.blue),
            tileColor: Colors.white,
            screen: const AdminGuide(),
          ),
          const Divider(),
        ],
      ),
    );
  }
}

