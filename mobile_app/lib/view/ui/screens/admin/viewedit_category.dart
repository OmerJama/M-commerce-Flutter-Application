import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/providers/providers.dart';
import 'package:mobile_app/view/ui/screens/admin/add_product_screen.dart';

class CategoriesViewEdit extends ConsumerStatefulWidget {
  const CategoriesViewEdit({Key? key}) : super(key: key);

  @override
  ConsumerState<CategoriesViewEdit> createState() => _CategoriesViewEditState();
}

var isSelected = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false
];
List<String> selectedSizes = [];

class _CategoriesViewEditState extends ConsumerState<CategoriesViewEdit> {
  final categoryNameEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fireStoreProvider = ref.read(firestoreProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your categories",
          style: TextStyle(fontFamily: 'Mula', fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: StreamBuilder(
          stream:
              fireStoreProvider!.firestore.collection("Categories").snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var document = snapshot.data!.docs[index].data();
                  return Slidable(
                    endActionPane: ActionPane(
                      motion: const ScrollMotion(),
                      children: [
                        SlidableAction(
                          icon: Icons.delete,
                          backgroundColor: Colors.red.shade700,
                          onPressed: (context) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: const Text(
                                    "Please confirm",
                                    style: TextStyle(fontFamily: 'Mula'),
                                  ),
                                  content: Text(
                                      "Are you sure you want to remove the category: ${snapshot.data!.docs[index].get('name')}?\n(This may have an effect on your categories section in your store)"),
                                  actions: [
                                    TextButton(
                                        onPressed: () {
                                          snapshot.data!.docs[index].reference
                                              .delete()
                                              .whenComplete(() {
                                            Navigator.pop(context);
                                            Fluttertoast.showToast(
                                                msg: "Category deleted");
                                          });
                                        },
                                        child: const Text("Yes")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancel"))
                                  ],
                                );
                              },
                            );
                          },
                        )
                      ],
                    ),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(10),
                      title: Text(document['name']),
                      leading: IconButton(
                          onPressed: () {
                            categoryNameEditingController.text =
                                document['name'];
                            showDialog(
                              context: context,
                              builder: (context) => Dialog(
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Form(
                                        child: Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Column(
                                        children: [
                                          categoryNameUpdateField(),
                                          const SizedBox(
                                            height: 20,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {
                                                if (categoryNameEditingController
                                                    .text.isEmpty) {
                                                  Fluttertoast.showToast(
                                                      msg:
                                                          "Category name cannot be empty");
                                                }
                                                if (categoryNameEditingController
                                                    .text.isNotEmpty) {
                                                  snapshot.data!.docs[index]
                                                      .reference
                                                      .update({
                                                    "name":
                                                        categoryNameEditingController
                                                            .text,
                                                  }).whenComplete(() {
                                                    Navigator.pop(context);
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "You have successfully updated your category");
                                                  });
                                                }
                                              },
                                              child: const Text(
                                                  "Update your category name")),
                                          ElevatedButton(
                                              onPressed: () async {
                                                final image =
                                                    await ImagePicker()
                                                        .pickImage(
                                                            source: ImageSource
                                                                .gallery);
                                                if (image != null) {
                                                  ref
                                                      .watch(
                                                          imageProvider.state)
                                                      .state = image;
                                                }
                                                final imageFiles = ref
                                                    .read(imageProvider.state)
                                                    .state;
                                                final fileStorage =
                                                    ref.read(storageProvider);
                                                final imageUrl =
                                                    await fileStorage!
                                                        .uploadFile(
                                                            imageFiles!.path);

                                                snapshot
                                                    .data!.docs[index].reference
                                                    .update({
                                                  "imageUrl": imageUrl,
                                                }).whenComplete(() {
                                                  Fluttertoast.showToast(
                                                      msg: "Photo updated");
                                                  ref
                                                      .watch(
                                                          imageProvider.state)
                                                      .state = null;
                                                });
                                              },
                                              child: const Text(
                                                  "Update your category image")),
                                        ],
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            );
                          },
                          icon: const Icon(Icons.edit)),
                      trailing: CachedNetworkImage(
                        imageUrl: document['imageUrl'],
                        height: 100,
                        width: 100,
                        fit: BoxFit.fill,
                      ),
                    ),
                  );
                },
              );
            } else {
              return const Text("Add categories to view them");
            }
          },
        ),
      ),
    );
  }

  TextFormField categoryNameUpdateField() {
    return TextFormField(
      controller: categoryNameEditingController,
      autofocus: false,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      validator: (productTitle) {
        if (productTitle!.isEmpty) {
          return "update cannot be empty";
        }
        return null;
      },
      onSaved: (newValue) {
        categoryNameEditingController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.category_outlined,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.all(20),
          labelText: "Update category name",
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.done,
    );
  }
}
