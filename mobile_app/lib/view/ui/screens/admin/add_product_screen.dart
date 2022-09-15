import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/models/product_model.dart';
import 'package:mobile_app/providers/providers.dart';
import 'package:mobile_app/view/ui/screens/admin/viewedit_products.dart';

class AddProductScreen extends ConsumerStatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddProductScreen> createState() => _AddProductScreenState();
}

final imageProvider = StateProvider<XFile?>(
  (ref) => null,
);

class _AddProductScreenState extends ConsumerState<AddProductScreen> {
  final fKey = GlobalKey<FormState>();
  final productTitleEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final smallEditingController = TextEditingController();
  final mediumEditingController = TextEditingController();
  final largeEditingController = TextEditingController();
  final xLargeEditingController = TextEditingController();
  // ignore: prefer_typing_uninitialized_variables
  var categoryItem;
  var setDefaultCategoryItem = true;

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

  @override
  Widget build(BuildContext context) {

    final productTitleField = TextFormField(
      controller: productTitleEditingController,
      autofocus: false,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      validator: (productTitle) {
        if (productTitle!.isEmpty) {
          return "Product name cannot be empty";
        }
        return null;
      },
      onSaved: (newValue) {
        productTitleEditingController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.title_outlined,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.all(20),
          labelText: "Product title",
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.next,
    );

    final productDescriptionField = TextFormField(
      controller: descriptionEditingController,
      autofocus: false,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      validator: (description) {
        if (description!.isEmpty) {
          return "Description";
        }
        return null;
      },
      onSaved: (newValue) {
        descriptionEditingController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.description_sharp,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.all(20),
          labelText: "Product description",
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.next,
      maxLines: null,
    );

    final priceField = TextFormField(
      controller: priceEditingController,
      autofocus: false,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))],
      enableInteractiveSelection: false,
      textCapitalization: TextCapitalization.sentences,
      validator: (price) {
        if (!RegExp(r'^\d{0,8}(\.\d{1,4})?$').hasMatch(price!)) {
          return "Enter a valid price";
        }

        if (price.isEmpty) {
          return "Price cannot be empty";
        }

        return null;
      },
      onSaved: (newValue) {
        priceEditingController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.price_change_outlined,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.all(20),
          labelText: "Price",
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.next,
    );

    final smallStock = TextFormField(
      controller: smallEditingController,
      autofocus: false,
      keyboardType: TextInputType.number,
      enableInteractiveSelection: false,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))],
      validator: (smallStock) {
        if (selectedSizes.contains("S") && smallStock!.isEmpty) {
          return "You selected this size, specify stock";
        }
        if (!selectedSizes.contains("S") && smallStock!.isNotEmpty) {
          return "You did not select this size";
        }
        if (!selectedSizes.contains("S") && smallStock!.isEmpty) {
          return null;
        }
        if (!RegExp(r"[0-9]").hasMatch(smallStock!) &&
            !selectedSizes.contains("S") &&
            smallStock.isEmpty) {
          return "Please enter a whole number";
        }

        return null;
      },
      onSaved: (newValue) {
        smallEditingController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.production_quantity_limits,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.all(20),
          labelText: "Stock for small",
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.done,
    );

    final mediumStock = TextFormField(
      controller: mediumEditingController,
      autofocus: false,
      enableInteractiveSelection: false,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))],
      keyboardType: TextInputType.number,
      validator: (mediumStock) {
        if (selectedSizes.contains("M") && mediumStock!.isEmpty) {
          return "You selected this size, specify stock";
        }
        if (!selectedSizes.contains("M") && mediumStock!.isNotEmpty) {
          return "You did not select this size";
        }
        if (!selectedSizes.contains("M") && mediumStock!.isEmpty) {
          return null;
        }
        if (!RegExp(r"[0-9]").hasMatch(mediumStock!) &&
            !selectedSizes.contains("S") &&
            mediumStock.isEmpty) {
          return "Please enter a whole number";
        }

        return null;
      },
      onSaved: (newValue) {
        mediumEditingController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.production_quantity_limits,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.all(20),
          labelText: "Stock for medium",
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.done,
    );

    final largeStock = TextFormField(
      controller: largeEditingController,
      autofocus: false,
      enableInteractiveSelection: false,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))],
      keyboardType: TextInputType.number,
      validator: (largeStock) {
        if (selectedSizes.contains("L") && largeStock!.isEmpty) {
          return "You selected this size, specify stock";
        }
        if (!selectedSizes.contains("L") && largeStock!.isNotEmpty) {
          return "You did not select this size";
        }
        if (!selectedSizes.contains("L") && largeStock!.isEmpty) {
          return null;
        }
        if (!RegExp(r"[0-9]").hasMatch(largeStock!) &&
            !selectedSizes.contains("S") &&
            largeStock.isEmpty) {
          return "Please enter a whole number";
        }

        return null;
      },
      onSaved: (newValue) {
        largeEditingController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.production_quantity_limits,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.all(20),
          labelText: "Stock for large",
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.done,
    );

    final xLargeStock = TextFormField(
      controller: xLargeEditingController,
      autofocus: false,
      enableInteractiveSelection: false,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))],
      keyboardType: TextInputType.number,
      validator: (xLargeStock) {
        if (selectedSizes.contains("XL") && xLargeStock!.isEmpty) {
          return "You selected this size, specify stock";
        }
        if (!selectedSizes.contains("XL") && xLargeStock!.isNotEmpty) {
          return "You did not select this size";
        }
        if (!selectedSizes.contains("XL") && xLargeStock!.isEmpty) {
          return null;
        }
        if (!RegExp(r"[0-9]").hasMatch(xLargeStock!) &&
            !selectedSizes.contains("S") &&
            xLargeStock.isEmpty) {
          return "Please enter a whole number";
        }

        return null;
      },
      onSaved: (newValue) {
        xLargeEditingController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.production_quantity_limits,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.all(20),
          labelText: "Stock for extra large",
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.done,
    );

    return WillPopScope(
      onWillPop: () async{
        ref.watch(imageProvider.state).state = null;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Add a product",
            style: TextStyle(fontFamily: 'Mula', fontWeight: FontWeight.bold),
          ),
          actions: [
            IconButton(onPressed: () {
             Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductsViewEdit(),)); 
            }, icon: const Icon(Icons.remove_red_eye))
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
                key: fKey,
                child: Column(
                  children: [
                    productTitleField,
                    const Divider(),
                    productDescriptionField,
                    const Divider(),
                    priceField,
                    const SizedBox(
                      height: 15,
                    ),
                    const Text("Select a category"),
                    const SizedBox(
                      height: 10,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance
                              .collection('Categories')
                              .orderBy('name')
                              .snapshots(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (!snapshot.hasData) {
                              return Container();
                            }
                            if (setDefaultCategoryItem) {
                              if (snapshot.hasData) {
                                if (snapshot.data!.docs.isNotEmpty) {
                                  categoryItem =
                                      snapshot.data!.docs[0].get('name');
                                }
                              }
                            }
                            return DropdownButtonFormField(
                              hint: const Text("Select a category"),
                              isExpanded: false,
                              value: categoryItem,
                              validator: (value) {
                                if (value.toString().isEmpty) {
                                  return "Please select a category";
                                }
                                return null;
                              },
                              items: snapshot.data!.docs.map((e) {
                                return DropdownMenuItem(
                                    value: e.get('name'),
                                    child: Text(e.get('name')));
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  categoryItem = value;
                                  setDefaultCategoryItem = false;
                                });
                              },
                            );
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Text("Select sizes available"),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        sizeSelection("S", isSelected[0], 0),
                        const Text("S"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 12,
                        ),
                        sizeSelection("M", isSelected[1], 1),
                        const Text("M"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 12,
                        ),
                        sizeSelection("L", isSelected[2], 2),
                        const Text("L"),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 12,
                        ),
                        sizeSelection("XL", isSelected[3], 3),
                        const Text("XL"),
                      ],
                    ),
                    const Divider(),
                    smallStock,
                    const Divider(),
                    mediumStock,
                    const Divider(),
                    largeStock,
                    const Divider(),
                    xLargeStock,
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(350, 50)),
                        onPressed: () {
                          addProduct();
                        },
                        child: const Text("Add product")),
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
                            ref.watch(imageProvider.state).state = image;
                          }
                        },
                        child: const Text("Upload product image")),
                    const SizedBox(
                      height: 20,
                    ),
                    Consumer(
                      builder: (context, ref, child) {
                        final image = ref.watch(imageProvider);
                        if (image == null) {
                          return const Text(
                            "No image selected",
                            style: TextStyle(fontFamily: 'Mula'),
                          );
                        } else {
                          return Image.file(
                            File(image.path),
                            height: 200,
                            key: UniqueKey(),
                          );
                        }
                      },
                    )
                  ],
                )),
          ),
        ),
      ),
    );
  }

  Checkbox sizeSelection(String size, bool? value, int index) {
    return Checkbox(
      value: isSelected[index],
      onChanged: (value) {
        setState(() {
          isSelected[index] = value!;
          if (selectedSizes.contains(size)) {
            selectedSizes.remove(size);
          } else {
            selectedSizes.add(size);
          }
        });
        // ignore: avoid_print
        print(selectedSizes);
      },
    );
  }

  Future<void> addProduct() async {
    final storage = ref.read(firestoreProvider);
    final fileStorage = ref.read(storageProvider);
    final imageFiles = ref.read(imageProvider.state).state;

    // ignore: unnecessary_null_comparison
    if (storage == null || imageProvider == null || fileStorage == null) {
      // ignore: avoid_print
      print("Storages are null");
      return;
    }
    if (imageFiles?.path == null) {
      Fluttertoast.showToast(
          msg: "Please complete all the fields first and upload an image");
      return;
    }

    final imageUrl = await fileStorage.uploadFile(imageFiles!.path);

    if (fKey.currentState!.validate()) {
      if (selectedSizes.isEmpty) {
        Fluttertoast.showToast(
            msg: "Please select at least one size to add this image");
        return;
      }

      if (double.parse(priceEditingController.text) <= 0) {
        Fluttertoast.showToast(msg: "Price cannot be zero");
        return;
      }

      if (categoryItem == null) {
        Fluttertoast.showToast(msg: "Please select a category");
        return;
      }

      String handlePrice =
          double.parse(priceEditingController.text.trim()).toStringAsFixed(2);
      double handlingPrice = double.parse(handlePrice);

      if (smallEditingController.text.isEmpty) {
        smallEditingController.text = "0";
      }
      if (mediumEditingController.text.isEmpty) {
        mediumEditingController.text = "0";
      }
      if (largeEditingController.text.isEmpty) {
        largeEditingController.text = "0";
      }
      if (xLargeEditingController.text.isEmpty) {
        xLargeEditingController.text = "0";
      }

      int stockTotal = (int.parse(smallEditingController.text)) +
          (int.parse(mediumEditingController.text) +
              (int.parse(largeEditingController.text) +
                  int.parse(xLargeEditingController.text)));

      List<String> productSplit = productTitleEditingController.text.split(' ');
      List<String> index = [];

      for (int i = 0; i < productSplit.length; i++) {
        for (int x = 1; x < productSplit[i].length + 1; x++) {
          index.add(productSplit[i].substring(0, x).toLowerCase());
        }
      }

      await storage.addProduct(Product(
          name: productTitleEditingController.text,
          description: descriptionEditingController.text,
          price: handlingPrice,
          imageUrl: imageUrl,
          category: categoryItem,
          sizes: selectedSizes.join(","),
          smallStock: int.parse(smallEditingController.text),
          mediumStock: int.parse(mediumEditingController.text),
          largeStock: int.parse(largeEditingController.text),
          xLargeStock: int.parse(xLargeEditingController.text),
          stock: stockTotal,
          searchArray: index));
      Fluttertoast.showToast(
          msg: "Product added successfully, please upload another image");
      productTitleEditingController.clear();
      descriptionEditingController.clear();
      priceEditingController.clear();
      smallEditingController.clear();
      mediumEditingController.clear();
      largeEditingController.clear();
      xLargeEditingController.clear();
      selectedSizes.clear;
      setState(() {
        ref.watch(imageProvider.state).state = null;
      });
    }
  }
}
