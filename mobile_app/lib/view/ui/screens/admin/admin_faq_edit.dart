import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile_app/providers/providers.dart';
import 'package:mobile_app/view/ui/screens/admin/admin_addfaq.dart';

class EditFaqScreen extends ConsumerStatefulWidget {
  const EditFaqScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<EditFaqScreen> createState() => _EditFaqScreenState();
}

class _EditFaqScreenState extends ConsumerState<EditFaqScreen> {
  final fKey = GlobalKey<FormState>();
  final questionTitleEditingController = TextEditingController();
  final answerEditingController = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    final fireStoreProvider = ref.watch(firestoreProvider);

    final questionTitleField = TextFormField(
      controller: questionTitleEditingController,
      autofocus: false,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      validator: (questionTitle) {
        if (questionTitle!.isEmpty) {
          return "Question cannot be empty";
        }
        return null;
      },
      onSaved: (newValue) {
        questionTitleEditingController.text = newValue!.trim();
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.question_mark,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.all(20),
          labelText: "Update question",
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey.shade50),
      textInputAction: TextInputAction.next,
    );
    final answerField = TextFormField(
      controller: answerEditingController,
      autofocus: false,
      keyboardType: TextInputType.name,
      minLines: 1,
      maxLines: 40,
      textCapitalization: TextCapitalization.sentences,
      validator: (answerField) {
        if (answerField!.isEmpty) {
          return "Answer cannot be empty";
        }
        return null;
      },
      onSaved: (newValue) {
        answerEditingController.text = newValue!.trim();
      },
      decoration: InputDecoration(
          prefixIcon: const Icon(
            Icons.question_mark,
            color: Colors.black,
          ),
          contentPadding: const EdgeInsets.all(20),
          labelText: "Update answer",
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey.shade50),
      focusNode: focusNode,
      textInputAction: TextInputAction.newline,
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text("FAQs editor"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddFaqScreen(),
              ));
        },
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
              stream:
                  fireStoreProvider!.firestore.collection("Faqs").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    Column(
                      children: [
                        const Text("Add FAQs to display it in your shop"),
                        Lottie.asset("assets/anim/anotheremptybox.json",
                            width: 200, repeat: true),
                      ],
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.docs.length,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      var document = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Slidable(
                          endActionPane: ActionPane(
                              motion: const ScrollMotion(), children: [
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
                                              "Are you sure you want to remove the FAQ: ${snapshot.data!.docs[index].get('question')}?\n(This will remove it from your store)"),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  snapshot.data!.docs[index]
                                                      .reference
                                                      .delete()
                                                      .whenComplete(() {
                                                    Navigator.pop(context);
                                                    Fluttertoast.showToast(
                                                        msg:
                                                            "FAQ deleted");
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
                            tileColor: Colors.white,
                            title: Text(
                              document['question'],
                              style: const TextStyle(
                                  fontFamily: 'Mula',
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              document['answer'],
                            ),
                            trailing: IconButton(
                                onPressed: () {
                                  questionTitleEditingController.text =
                                      document['question'];
                                  answerEditingController.text =
                                      document['answer'];
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return Dialog(
                                        clipBehavior: Clip.hardEdge,
                                        // ignore: avoid_unnecessary_containers
                                        child: Container(
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(15.0),
                                              child: ListView(
                                                shrinkWrap: true,
                                                children: [
                                                  Form(
                                                      key: fKey,
                                                      child: Column(
                                                        children: [
                                                          questionTitleField,
                                                          const Divider(),
                                                          answerField,
                                                        ],
                                                      )),
                                                  const SizedBox(
                                                    height: 40,
                                                  ),
                                                  ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                              minimumSize:
                                                                  const Size(
                                                                      350, 50)),
                                                      onPressed: () {
                                                        focusNode.unfocus();
                                                        if (fKey.currentState!
                                                            .validate()) {
                                                          snapshot
                                                              .data!
                                                              .docs[index]
                                                              .reference
                                                              .update({
                                                            "question":
                                                                questionTitleEditingController
                                                                    .text,
                                                            "answer":
                                                                answerEditingController
                                                                    .text,
                                                          }).whenComplete(() =>
                                                                  Navigator.pop(
                                                                      context));
                                                        }
                                                      },
                                                      child: const Text(
                                                          "Add question")),
                                                ],
                                              )),
                                        ),
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(Icons.edit)),
                          ),
                        ),
                      );
                    },
                  );
                }
                return const Text("");
              },
            )
          ],
        ),
      ),
    );
  }
}
