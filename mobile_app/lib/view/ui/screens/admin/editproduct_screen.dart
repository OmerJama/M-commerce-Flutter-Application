import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/view/ui/screens/admin/add_product_screen.dart';
import 'package:mobile_app/providers/providers.dart';

// ignore: must_be_immutable
class EditProductScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic> document;
  final dynamic id;
  final TextEditingController productTitleEditingController;
  final TextEditingController descriptionEditingController;
  final TextEditingController priceEditingController;
  final TextEditingController smallEditingController;
  final TextEditingController mediumEditingController;
  final TextEditingController largeEditingController;
  final TextEditingController xLargeEditingController;
  final TextFormField nameField;
  final TextFormField descriptionField;
  final TextFormField priceField;
  final TextFormField smallStockField;
  final TextFormField mediumStockField;
  final TextFormField largeStockField;
  final TextFormField xLargeStockField;

  EditProductScreen({
    Key? key,
    required this.document,
    required this.id,
    required this.productTitleEditingController,
    required this.descriptionEditingController,
    required this.priceEditingController,
    required this.smallEditingController,
    required this.largeEditingController,
    required this.mediumEditingController,
    required this.xLargeEditingController,
    required this.nameField,
    required this.descriptionField,
    required this.priceField,
    required this.smallStockField,
    required this.mediumStockField,
    required this.largeStockField,
    required this.xLargeStockField,
  }) : super(key: key);

  var isSelected = [
    true,
    true,
    false,
    false,
  ];
  List<String> selectedSizes = [];
  // ignore: prefer_typing_uninitialized_variables
  var categoryItem;
  var setDefaultCategoryItem = true;

  @override
  ConsumerState<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends ConsumerState<EditProductScreen> {
  bool smallIsChecked = false;
  bool mediumIsChecked = false;
  bool largeIsChecked = false;
  // ignore: non_constant_identifier_names
  bool XLIsChecked = false;

  final fKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final firebaseProvider = ref.watch(firestoreProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Editing"),
        centerTitle: true,
      ),
      body: Consumer(
        builder: (context, ref, child) {
          return StreamBuilder(
            stream: firebaseProvider!.firestore
                .collection("Products")
                .where('id', isEqualTo: widget.id)
                .snapshots(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  if (snapshot.hasData) {
                    var document = snapshot.data!.docs[index].data();

                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                          key: fKey,
                          child: Column(
                            children: [
                              widget.nameField,
                              const Divider(),
                              widget.descriptionField,
                              const Divider(),
                              widget.priceField,
                              const SizedBox(
                                height: 20,
                              ),
                              const Text("Update category"),
                              Text(
                                  "You previously selected: ${document['Category']}"),
                              Consumer(
                                builder: (context, ref, child) {
                                  return StreamBuilder(
                                    stream: firebaseProvider.firestore
                                        .collection("Categories")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return Container();
                                      }
                                      if (widget.setDefaultCategoryItem) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data!.docs.isNotEmpty) {
                                            if (document['Category'] == null) {
                                              widget.categoryItem = snapshot
                                                  .data!.docs[0]
                                                  .get('name');
                                            }
                                            else{
                                              widget.categoryItem = document['Category'];
                                            }
                                          }
                                        }
                                      }
                                      return DropdownButtonFormField(
                                        validator: (value) {
                                          if (value.toString().isEmpty) {
                                            return "Category cannot be empty";
                                          }
                                          return null;
                                        },
                                        hint: Text(document['Category']),
                                        items: snapshot.data!.docs.map((e) {
                                          return DropdownMenuItem(
                                              value: e.get('name'),
                                              child: Text(e.get('name')));
                                        }).toList(),
                                        onChanged: (value) {
                                          setState(() {
                                            widget.categoryItem = value;
                                            widget.setDefaultCategoryItem =
                                                false;
                                          });
                                        },
                                      );
                                    },
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 25,
                              ),
                              const Text("Update stock"),
                              Text(
                                  "You previously selected: ${document['Sizes']}"),
                              const SizedBox(
                                height: 25,
                              ),
                              widget.smallStockField,
                              const Divider(),
                              widget.mediumStockField,
                              const Divider(),
                              widget.largeStockField,
                              const Divider(),
                              widget.xLargeStockField,
                              const SizedBox(height: 25),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(350, 50)),
                                  onPressed: () {
                                    if (widget.productTitleEditingController
                                            .text.isEmpty ||
                                        widget.descriptionEditingController.text
                                            .isEmpty ||
                                        widget.descriptionEditingController.text
                                            .isEmpty) {
                                      Fluttertoast.showToast(
                                          msg:
                                              "Required field cannot be empty");
                                      return;
                                    }
                                    if (fKey.currentState!.validate()) {
                                      if (widget.smallEditingController.text
                                              .isNotEmpty &&
                                          widget.smallEditingController.text !=
                                              '0') {
                                        if (!widget.selectedSizes
                                            .contains('S')) {
                                          widget.selectedSizes.add('S');
                                        }
                                      } else if (widget.smallEditingController
                                              .text.isEmpty ||
                                          widget.smallEditingController.text ==
                                              '0') {
                                        if (widget.selectedSizes
                                            .contains('S')) {
                                          widget.selectedSizes.remove('S');
                                        }
                                      }
                                      if (widget.mediumEditingController.text
                                              .isNotEmpty &&
                                          widget.mediumEditingController.text !=
                                              '0') {
                                        if (!widget.selectedSizes
                                            .contains('M')) {
                                          widget.selectedSizes.add('M');
                                        }
                                      } else if (widget.mediumEditingController
                                              .text.isEmpty ||
                                          widget.mediumEditingController.text ==
                                              '0') {
                                        if (widget.selectedSizes
                                            .contains('M')) {
                                          widget.selectedSizes.remove('M');
                                        }
                                      }

                                      if (widget.largeEditingController.text
                                              .isNotEmpty &&
                                          widget.largeEditingController.text !=
                                              '0') {
                                        if (!widget.selectedSizes
                                            .contains('L')) {
                                          widget.selectedSizes.add('L');
                                        }
                                      } else if (widget.largeEditingController
                                              .text.isEmpty ||
                                          widget.largeEditingController.text ==
                                              '0') {
                                        if (widget.selectedSizes
                                            .contains('L')) {
                                          widget.selectedSizes.remove('L');
                                        }
                                      }

                                      if (widget.xLargeEditingController.text
                                              .isNotEmpty &&
                                          widget.xLargeEditingController.text !=
                                              '0') {
                                        if (!widget.selectedSizes
                                            .contains('XL')) {
                                          widget.selectedSizes.add('XL');
                                        }
                                      } else if (widget.xLargeEditingController
                                              .text.isEmpty ||
                                          widget.xLargeEditingController.text ==
                                              '0') {
                                        if (widget.selectedSizes
                                            .contains('XL')) {
                                          widget.selectedSizes.remove('XL');
                                        }
                                      }

                                      if (widget.smallEditingController.text
                                          .isEmpty) {
                                        widget.smallEditingController.text =
                                            "0";
                                      }
                                      if (widget.mediumEditingController.text
                                          .isEmpty) {
                                        widget.mediumEditingController.text =
                                            "0";
                                      }
                                      if (widget.largeEditingController.text
                                          .isEmpty) {
                                        widget.largeEditingController.text =
                                            "0";
                                      }
                                      if (widget.xLargeEditingController.text
                                          .isEmpty) {
                                        widget.xLargeEditingController.text =
                                            "0";
                                      }

                                      //calculating new total stock
                                      int stockTotal = (int.parse(widget
                                              .smallEditingController.text)) +
                                          (int.parse(widget
                                                  .mediumEditingController
                                                  .text) +
                                              (int.parse(widget
                                                      .largeEditingController
                                                      .text) +
                                                  int.parse(widget
                                                      .xLargeEditingController
                                                      .text)));

                                      if (widget.selectedSizes.isNotEmpty) {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          "Small stock": int.parse(widget
                                              .smallEditingController.text),
                                        }).whenComplete(() {
                                          // Fluttertoast.showToast(
                                          //     msg: "Small stock updated");
                                        });
                                      } else {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          "Small stock": 0,
                                        });
                                      }
                                      if (widget.selectedSizes.isNotEmpty) {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          "Medium stock": int.parse(widget
                                              .mediumEditingController.text),
                                        }).whenComplete(() {
                                          // Fluttertoast.showToast(
                                          //     msg: "Medium stock updated");
                                        });
                                      } else {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          "Medium stock": 0,
                                        });
                                      }
                                      if (widget.selectedSizes.isNotEmpty) {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          "Large stock": int.parse(widget
                                              .largeEditingController.text),
                                        }).whenComplete(() {
                                          // Fluttertoast.showToast(
                                          //     msg: "Large stock updated");
                                        });
                                      } else {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          "Large stock": 0,
                                        });
                                      }
                                      if (widget.selectedSizes.isNotEmpty) {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          "X Large stock": int.parse(widget
                                              .xLargeEditingController.text),
                                        }).whenComplete(() {
                                          // Fluttertoast.showToast(
                                          //     msg: "Extra large stock updated");
                                        });
                                      } else {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          "X Large stock": 0,
                                        });
                                      }
                                      if (stockTotal.isFinite) {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          "Stock": stockTotal,
                                        }).whenComplete(() {
                                          // Fluttertoast.showToast(
                                          //     msg: "Extra large stock updated");
                                        });
                                      }

                                      if (widget.selectedSizes.isNotEmpty) {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          "Sizes":
                                              widget.selectedSizes.join(','),
                                        }).whenComplete(() {
                                          // Fluttertoast.showToast(
                                          //     msg:
                                          //         "You have successfully updated your stock level and sizes");
                                        });
                                      }
                                      if (widget.productTitleEditingController
                                              .text.isNotEmpty &&
                                          widget.productTitleEditingController !=
                                              document['name']) {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          "name": widget
                                              .productTitleEditingController
                                              .text,
                                        }).whenComplete(() {
                                          // Fluttertoast.showToast(
                                          //     msg:
                                          //         "You have successfully updated your product name");
                                        });
                                      }
                                      if (widget.descriptionEditingController
                                          .text.isNotEmpty) {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          "description": widget
                                              .descriptionEditingController
                                              .text,
                                        }).whenComplete(() {
                                          // Fluttertoast.showToast(
                                          //     msg:
                                          //         "You have successfully updated your product description");
                                        });
                                      }
                                      if (widget.priceEditingController.text
                                          .isNotEmpty) {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          "price": double.parse(widget
                                              .priceEditingController.text),
                                        }).whenComplete(() {
                                          // Fluttertoast.showToast(
                                          //     msg:
                                          //         "You have successfully updated your product price");
                                        });
                                      }
                                      if (widget.categoryItem != null) {
                                        snapshot.data!.docs[index].reference
                                            .update({
                                          "Category": widget.categoryItem,
                                        }).whenComplete(() {
                                          // Fluttertoast.showToast(
                                          //     msg:
                                          //         "You have successfully updated your product category");
                                        });
                                      }
                                      Navigator.pop(context);
                                      Fluttertoast.showToast(
                                          msg: "Product updated");
                                    }
                                  },
                                  child: const Text("Update product")),
                              const SizedBox(
                                height: 10,
                              ),
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: const Size(350, 50)),
                                  onPressed: () async {
                                    final image = await ImagePicker()
                                        .pickImage(source: ImageSource.gallery);
                                    if (image != null) {
                                      ref.watch(imageProvider.state).state =
                                          image;
                                    }
                                    final imageFiles =
                                        ref.read(imageProvider.state).state;
                                    final fileStorage =
                                        ref.read(storageProvider);
                                    final imageUrl = await fileStorage!
                                        .uploadFile(imageFiles!.path);

                                    snapshot.data!.docs[index].reference
                                        .update({
                                      "ImageUrl": imageUrl,
                                    }).whenComplete(() =>
                                            Fluttertoast.showToast(
                                                msg: "Photo updated"));
                                  },
                                  child: const Text("Update image")),
                              const SizedBox(
                                height: 20,
                              ),
                              Image.network(
                                document['ImageUrl'].toString(),
                                height: 200,
                                width: 200,
                                fit: BoxFit.fill,
                              )
                            ],
                          )),
                    );
                  }
                  return const Text("");
                },
              );
            },
          );
        },
      ),
    );
  }
}
