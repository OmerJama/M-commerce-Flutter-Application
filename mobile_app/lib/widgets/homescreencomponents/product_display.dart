import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/services/firestore_service.dart';
import 'package:mobile_app/view/ui/screens/user/product_detail.dart';

class ProductDisplay extends StatelessWidget {
  const ProductDisplay({
    Key? key,
    required this.fireStoreProvider,
  }) : super(key: key);

  final FirestoreService? fireStoreProvider;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: fireStoreProvider!.firestore.collection("Products").where('Stock', isGreaterThan: 0).snapshots(),
      builder: (context, snapshot) {
       if (snapshot.connectionState == ConnectionState.active &&
      snapshot.data != null) {
    if (snapshot.data!.docs.isEmpty) {
      return Container();
    }
    return SizedBox(
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          itemCount: snapshot.data?.docs.length,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              childAspectRatio: 0.7,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            final product = snapshot.data!.docs[index];
            final id = snapshot.data!.docs[index].id;
            return GestureDetector(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetail(product: product, documentId: id),));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  key: const Key("homeProduct"),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                   
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15.0),
                          child: CachedNetworkImage(
                            imageUrl: product['ImageUrl'],
                            width: double.infinity,
                            height: 130,
                            fit: BoxFit.fill
                            
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        product['name'],
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        // ignore: unnecessary_string_escapes
                        "\£${product['price'].toStringAsFixed(2)}",
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
    );
              }
              return const Center(child:  CircularProgressIndicator(),);
    },);
  }
}