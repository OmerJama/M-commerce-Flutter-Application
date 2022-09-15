import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/providers/providers.dart';
import 'package:mobile_app/view/ui/screens/admin/editproduct_screen.dart';

class ProductsViewEdit extends ConsumerStatefulWidget {
  const ProductsViewEdit({Key? key}) : super(key: key);

  @override
  ConsumerState<ProductsViewEdit> createState() => _ProductsViewEditState();
}

var isSelected = [
  false,
  false,
  false,
  false,
];
List<String> selectedSizes = [];
// ignore: prefer_typing_uninitialized_variables
var categoryItem;
var setDefaultCategoryItem = true;

class _ProductsViewEditState extends ConsumerState<ProductsViewEdit> {
  final productTitleEditingController = TextEditingController();
  final descriptionEditingController = TextEditingController();
  final priceEditingController = TextEditingController();
  final smallEditingController = TextEditingController();
  final mediumEditingController = TextEditingController();
  final largeEditingController = TextEditingController();
  final xLargeEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final fireStoreProvider = ref.read(firestoreProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your products"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              StreamBuilder(
                stream: fireStoreProvider!.firestore
                    .collection("Products")
                    .orderBy('Category')
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        var document = snapshot.data!.docs[index].data();
                        var id = snapshot.data!.docs[index].get('id');
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
                                            style:
                                                TextStyle(fontFamily: 'Mula'),
                                          ),
                                          content: Text(
                                              "Are you sure you want to remove the product: ${snapshot.data!.docs[index].get('name')}?\n(This will remove it from your store)"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  snapshot.data!.docs[index]
                                                      .reference
                                                      .delete()
                                                      .whenComplete(() {
                                                    Navigator.pop(context);
                                                    Fluttertoast.showToast(
                                                        msg: "Product deleted");
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
                              ]),
                          child: ListTile(
                            leading: IconButton(
                              onPressed: () {
                                productTitleEditingController.text =
                                    document['name'];
                                descriptionEditingController.text =
                                    document['description'];
                                priceEditingController.text =
                                    document['price'].toString();
                                smallEditingController.text =
                                    document['Small stock'].toString();
                                    if (document['Small stock'] <= 0) {
                                      smallEditingController.text = 0.toString();
                                    }
                                mediumEditingController.text =
                                    document['Medium stock'].toString();
                                    if (document['Medium stock'] <= 0) {
                                      mediumEditingController.text = 0.toString();
                                    }
                                largeEditingController.text =
                                    document['Large stock'].toString();
                                    if (document['Large stock'] <= 0) {
                                      largeEditingController.text = 0.toString();
                                    }
                                xLargeEditingController.text =
                                    document['X Large stock'].toString();
                                    if (document['X Large stock'] <= 0) {
                                      xLargeEditingController.text = 0.toString();
                                    }
                                Navigator.push(context, MaterialPageRoute(
                                  builder: (context) {
                                    return EditProductScreen(
                                      document: document,
                                      id: id,
                                      productTitleEditingController:
                                          productTitleEditingController,
                                      descriptionEditingController:
                                          descriptionEditingController,
                                      priceEditingController:
                                          priceEditingController,
                                       smallEditingController: smallEditingController,
                                       largeEditingController: largeEditingController,
                                       mediumEditingController: mediumEditingController,
                                       xLargeEditingController: xLargeEditingController,   
                                      nameField: nameField(),
                                      descriptionField: descriptionField(),
                                      priceField: priceField(),
                                      smallStockField: smallStockField(),
                                      mediumStockField: mediumStockField(),
                                      largeStockField: largeStockField(),
                                      xLargeStockField: xLargeStockField(),
                                    );
                                  },
                                ));
                              },
                              icon: const Icon(Icons.edit),
                            ),
                            contentPadding: const EdgeInsets.all(15),
                            title: Text(document['name']),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("S   stock: ${document['Small stock']}"),
                                Text("M  stock: ${document['Medium stock']}"),
                                Text("L   stock: ${document['Large stock']}"),
                                Text("XL stock: ${document['X Large stock']}")
                              ],
                            ),
                            trailing: CachedNetworkImage(
                              imageUrl: document['ImageUrl'],
                              height: 300,
                              width: 100,
                              fit: BoxFit.fill,
                            ),
                          ),
                        );
                      },
                    );
                  } else {
                    return const Text("");
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField nameField() {
    return TextFormField(
      controller: productTitleEditingController,
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
        productTitleEditingController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.category_outlined,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.all(20),
          labelText: "Update product name",
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.next,
    );
  }

  TextFormField descriptionField() {
    return TextFormField(
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
      textInputAction: TextInputAction.newline,
      maxLines: null,
    );
  }

  TextFormField priceField() {
    return TextFormField(
      controller: priceEditingController,
      autofocus: false,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9.]"))],
      enableInteractiveSelection: false,
      textCapitalization: TextCapitalization.sentences,
      validator: (price) {
        int decimalcount = 0;
        if (!RegExp(r'^\d{0,8}(\.\d{1,4})?$').hasMatch(price!)) {
          return "Enter a valid price";
        }
        if (decimalcount > 1) {
          return "Please enter a valid number";
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
  }

  TextFormField smallStockField() {
    return TextFormField(
      controller: smallEditingController,
      autofocus: false,
      keyboardType: TextInputType.number,
      enableInteractiveSelection: false,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))],
      validator: (smallStock) {
        if (smallStock!.isEmpty) {
          return null;
        }
        if (!RegExp(r"[0-9]").hasMatch(smallStock) &&
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
  }

  TextFormField mediumStockField() {
    return TextFormField(
      controller: mediumEditingController,
      autofocus: false,
      enableInteractiveSelection: false,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))],
      keyboardType: TextInputType.number,
      validator: (mediumStock) {
        if (mediumStock!.isEmpty) {
          return null;
        }

        if (!RegExp(r"[0-9]").hasMatch(mediumStock) &&
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
  }

  TextFormField largeStockField() {
    return TextFormField(
      controller: largeEditingController,
      autofocus: false,
      enableInteractiveSelection: false,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))],
      keyboardType: TextInputType.number,
      validator: (largeStock) {
        if (largeStock!.isEmpty) {
          return null;
        }
        if (!RegExp(r"[0-9]").hasMatch(largeStock) &&
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
  }

  TextFormField xLargeStockField() {
    return TextFormField(
      controller: xLargeEditingController,
      autofocus: false,
      enableInteractiveSelection: false,
      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r"[0-9]"))],
      keyboardType: TextInputType.number,
      validator: (xLargeStock) {
        if (xLargeStock!.isEmpty) {
          return null;
        }
        if (!RegExp(r"[0-9]").hasMatch(xLargeStock) &&
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
  }
}
