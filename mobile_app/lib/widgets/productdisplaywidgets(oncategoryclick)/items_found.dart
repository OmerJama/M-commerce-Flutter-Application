import 'package:flutter/material.dart';
import 'package:mobile_app/services/firestore_service.dart';
import 'package:mobile_app/widgets/homescreencomponents/category_product_display.dart';

class ItemsFound extends StatelessWidget {
  const ItemsFound({
    Key? key,
    required this.fireStoreProvider,
    required this.widget,
  }) : super(key: key);

  final FirestoreService? fireStoreProvider;
  final CategoryProductDisplay widget;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        StreamBuilder(
          stream: fireStoreProvider!.firestore
              .collection("Products")
              .where('Category',
                  isEqualTo: widget.categoryDocument['name'])
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Text(
                "${snapshot.data!.docs.length} items found",
                style:
                    const TextStyle(fontFamily: 'Grotesk', color: Colors.grey),
              );
            } else {
              return const Text("");
            }
          },
        )
      ],
    );
  }
}