import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mobile_app/models/faq_model.dart';
import 'package:mobile_app/providers/providers.dart';

class AddFaqScreen extends ConsumerStatefulWidget {
  const AddFaqScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<AddFaqScreen> createState() => _AddFaqScreenState();
}

class _AddFaqScreenState extends ConsumerState<AddFaqScreen> {
  final fKey = GlobalKey<FormState>();
  final questionTitleEditingController = TextEditingController();
  final answerEditingController = TextEditingController();
  final focusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
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
          labelText: "Add a question",
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
          labelText: "Add an answer",
          labelStyle: const TextStyle(color: Colors.black),
          filled: true,
          fillColor: Colors.grey.shade50),
          focusNode: focusNode,
      textInputAction: TextInputAction.newline,
    );

    return GestureDetector(
      onTap: () => focusNode.unfocus(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add a FAQ"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Form(
              key: fKey,
                child: Column(
              children: [
                questionTitleField,
                const Divider(),
                answerField,
                const SizedBox(height: 40,),
                ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(350, 50)),
                          onPressed: () {
                            focusNode.unfocus();
                            addFaq();
                          },
                          child: const Text("Add question")),
              ],
            )),
          ),
        ),
      ),
    );
  }


  Future<void> addFaq() async{
    final storage = ref.read(firestoreProvider);

    if (storage == null) {
      return;
    }

    if (fKey.currentState!.validate()) {
      try {
        await storage.addFaq(FaqModel(question: questionTitleEditingController.text, answer: answerEditingController.text));
        Fluttertoast.showToast(msg: "The question: ${questionTitleEditingController.text} has been added");
        questionTitleEditingController.clear();
        answerEditingController.clear();
      } catch (e) {
        // ignore: avoid_print
        print(e.toString());
      }
      
    }
    

  }
}
