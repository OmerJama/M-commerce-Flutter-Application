import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile_app/view/ui/screens/admin/add_product_screen.dart';
import 'package:mobile_app/models/category_model.dart';
import 'package:mobile_app/providers/providers.dart';
import 'package:mobile_app/view/ui/screens/admin/viewedit_category.dart';

class AddCategoryScreen extends ConsumerStatefulWidget {
  const AddCategoryScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends ConsumerState<AddCategoryScreen> {
  final fKey = GlobalKey<FormState>();
  final categoryController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final productTitleField = TextFormField(
      controller: categoryController,
      autofocus: false,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      validator: (productTitle) {
        if (productTitle!.isEmpty) {
          return "Category cannot be empty";
        }
        return null;
      },
      onSaved: (newValue) {
        categoryController.text = newValue!;
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.category_outlined,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.all(20),
          labelText: "Category name",
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.done,
    );

    return WillPopScope(
      onWillPop: () async {
        ref.watch(imageProvider.state).state = null;
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CategoriesViewEdit(),
                      ));
                },
                icon: const Icon(Icons.remove_red_eye))
          ],
          centerTitle: true,
          title: const Text(
            "Add a category",
            style: TextStyle(fontFamily: 'Mula', fontWeight: FontWeight.bold),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            // ignore: avoid_unnecessary_containers
            child: Container(
              child: Form(
                  key: fKey,
                  child: Column(
                    children: [
                      productTitleField,
                      const SizedBox(
                        height: 40,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(350, 50)),
                          onPressed: () {
                            addCategory();
                          },
                          child: const Text("Add category")),
                      const SizedBox(
                        height: 20,
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
                          return image == null
                              ? const Text(
                                  "No image selected",
                                  style: TextStyle(fontFamily: 'Mula'),
                                )
                              : Image.file(
                                  File(image.path),
                                  height: 200,
                                );
                        },
                      )
                    ],
                  )),
            ),
          ),
        ),
      ),
    );
  }

  void addCategory() async {
    final firestoreStorage = ref.read(firestoreProvider);
    final storage = ref.read(firestoreProvider);
    final fileStorage = ref.read(storageProvider);
    final imageFiles = ref.read(imageProvider.state).state;

    // ignore: unnecessary_null_comparison
    if (storage == null || imageProvider == null || fileStorage == null) {
      // ignore: avoid_print
      print("Error: storage error");
      return;
    }
    if (imageFiles?.path == null) {
      Fluttertoast.showToast(msg: "Please upload a category icon");
      return;
    }

    final imageUrl = await fileStorage.uploadFile(imageFiles!.path);

    if (fKey.currentState!.validate()) {
      await firestoreStorage!.addCategory(Category(
        name: categoryController.text,
        imageUrl: imageUrl,
      ));
      categoryController.clear();
      Fluttertoast.showToast(msg: "Category added successfully");
      ref.watch(imageProvider.state).state = null;
    }
  }
}
