// ignore_for_file: sized_box_for_whitespace

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/providers/providers.dart';
import 'package:mobile_app/view/ui/screens/user/product_detail.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  // ignore: prefer_typing_uninitialized_variables
  var searchInput;
  @override
  Widget build(BuildContext context) {
    final fireStoreProvider = ref.read(firestoreProvider);
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(2.0),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, left: 10, bottom: 10),
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * 0.75,
                        height: 40,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade600.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: TextField(
                          autofocus: false,
                          onChanged: (value) {
                            setState(() {
                              searchInput = value.trim();
                            });
                          },
                          decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.search,
                              ),
                              hintText: "Search Item",
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 7)),
                          textInputAction: TextInputAction.done,
                        ),
                      )
                    ],
                  ),
                ),
               
                Container(
                  height: MediaQuery.of(context).size.height,
                  child: StreamBuilder(
                stream: fireStoreProvider!.firestore
                    .collection("Products")
                    .where("Search Index", arrayContains: searchInput?.toLowerCase())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Text("No results found");
                  }
                  return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data?.docs.length,
                      shrinkWrap: false,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
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
                              height: 50,
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(15.0),
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
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    // ignore: unnecessary_string_escapes
                                    "\£${product['price'].toStringAsFixed(2)}",
                                    style: TextStyle(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      });
                },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
