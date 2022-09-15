import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/providers/providers.dart';
import 'package:mobile_app/view/ui/screens/user/wishlist_screen.dart';
import 'package:mobile_app/widgets/productdisplaywidgets(oncategoryclick)/items_found.dart';
import 'package:mobile_app/widgets/productdisplaywidgets(oncategoryclick)/product_display_category.dart';

class CategoryProductDisplay extends ConsumerStatefulWidget {
  final QueryDocumentSnapshot<Map<String, dynamic>> categoryDocument;
  const CategoryProductDisplay({Key? key, required this.categoryDocument})
      : super(key: key);

  @override
  ConsumerState<CategoryProductDisplay> createState() =>
      _CategoryProductDisplayState();
}

class _CategoryProductDisplayState
    extends ConsumerState<CategoryProductDisplay> {
  String dropdownValue = 'All products';
  @override
  Widget build(BuildContext context) {
    final fireStoreProvider = ref.read(firestoreProvider);

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: Text(
          widget.categoryDocument['name'],
          style: const TextStyle(
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
                Navigator.push(context, MaterialPageRoute(builder: (context) => const WishlistScreen(),));
              },
              icon: const Icon(
                Icons.favorite_border,
                color: Colors.black,
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(top: 8, left: 8, right: 0),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border(
                  bottom: BorderSide(width: 1.0, color: Colors.grey.shade100),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: Row(
                  children: [
                    DropdownButtonHideUnderline(
                      child: DropdownButton(
                        hint: const Text("Select size", style: TextStyle(color: Colors.black),),
                        style: const TextStyle(
                            fontFamily: 'Grotesk',
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                        value: dropdownValue,
                        items: <String>[
                          'All products',
                          'Price - Low to High',
                          'Price - High to Low'
                        ].map<DropdownMenuItem<String>>((String toSave) {
                          return DropdownMenuItem<String>(
                            value: toSave,
                            child: Text(toSave),
                          );
                        }).toList(),
                        onChanged: (toSave) {
                          setState(() {
                            dropdownValue = toSave!;
                            debugPrint(dropdownValue);
                            // ignore: avoid_print
                            print(toSave);
                          });
                        },
                      ),
                    ),
                    const Spacer(),
                    
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ItemsFound(fireStoreProvider: fireStoreProvider, widget: widget),
            ProductDisplayUnderCategories(fireStoreProvider: fireStoreProvider, widget: widget, dropdownValue: dropdownValue,)
          ],
        ),
      ),
    );
  }
}


