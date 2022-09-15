import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app/services/firestore_service.dart';
import 'package:mobile_app/widgets/homescreencomponents/category_product_display.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({
    Key? key,
    required this.fireStoreProvider,
  }) : super(key: key);

  final FirestoreService? fireStoreProvider;

  @override
  Widget build(BuildContext context) {
    // ignore: sized_box_for_whitespace
    return Container(
      height: 40,
      child: StreamBuilder(
        stream: fireStoreProvider!.firestore
            .collection('Categories')
            .orderBy('name')
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active &&
              snapshot.data != null) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  var document = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.only(right: 15, left: 15),
                    child: GestureDetector(
                      onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => CategoryProductDisplay(categoryDocument: document),));
                    },
                      // ignore: sized_box_for_whitespace
                      child: Container(
                        height: 50,
                        width: MediaQuery.of(context).size.width/3.5,
                        child: Row(
                          children: [
                            CachedNetworkImage(
                              imageUrl: document['imageUrl'],
                              height: 30,
                              width: 30,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Text(
                                document['name'],
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'Grotesk'
                                    ),
                              ),
                            ),
                            const Divider(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }
          return Container();
        },
      ),
    );
  }
}