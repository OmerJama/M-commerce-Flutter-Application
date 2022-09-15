import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/services/firestore_service.dart';
import 'package:mobile_app/view/ui/screens/user/product_detail.dart';
import 'package:mobile_app/widgets/homescreencomponents/category_product_display.dart';

class ProductDisplayUnderCategories extends StatelessWidget {
  const ProductDisplayUnderCategories(
      {Key? key,
      required this.fireStoreProvider,
      required this.widget,
      required this.dropdownValue})
      : super(key: key);

  final FirestoreService? fireStoreProvider;
  final CategoryProductDisplay widget;
  final String dropdownValue;

  @override
  Widget build(BuildContext context) {
    if (dropdownValue == 'All products') {
      return StreamBuilder(
        stream: fireStoreProvider!.firestore
            .collection("Products")
            .where('Category', isEqualTo: widget.categoryDocument['name'])
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.data != null) {
            if (snapshot.data!.docs.isEmpty) {
              return Container();
            }

            return SizedBox(
              child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemCount: snapshot.data?.docs.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      childAspectRatio: 0.6, crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final product = snapshot.data!.docs[index];
                    final documentId = snapshot.data!.docs[index].id;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                  product: product, documentId: documentId),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
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
                                      fit: BoxFit.fill),
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
          return const Center(
            child: Text(""),
          );
        },
      );
    } else if (dropdownValue == 'Price - High to Low') {
      return StreamBuilder(
        stream: fireStoreProvider!.firestore
            .collection("Products")
            .orderBy('price', descending: true)
            .where('Category', isEqualTo: widget.categoryDocument['name'])
            .snapshots(),
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
                      childAspectRatio: 0.6, crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final product = snapshot.data!.docs[index];
                    final documentId = snapshot.data!.docs[index].id;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                product: product,
                                documentId: documentId,
                              ),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
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
                                      fit: BoxFit.fill),
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
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
          return const Center(
            child: Text(""),
          );
        },
      );
    } else if (dropdownValue == 'Price - Low to High') {
      return StreamBuilder(
        stream: fireStoreProvider!.firestore
            .collection("Products")
            .orderBy('price', descending: false)
            .where('Category', isEqualTo: widget.categoryDocument['name'])
            .snapshots(),
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
                    childAspectRatio: 0.6,
                      crossAxisCount: 2),
                  itemBuilder: (context, index) {
                    final product = snapshot.data!.docs[index];
                    final documentId = snapshot.data!.docs[index].id;

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductDetail(
                                product: product,
                                documentId: documentId,
                              ),
                            ));
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
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
                                      fit: BoxFit.fill),
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
                                "£${product['price'].toStringAsFixed(2)}",
                                style: TextStyle(
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
          return const Center(
            child: Text(""),
          );
        },
      );
    }
    return const Text("");
  }
}
