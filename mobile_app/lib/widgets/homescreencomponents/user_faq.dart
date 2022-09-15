import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/providers/providers.dart';

class FaqScreen extends ConsumerStatefulWidget {
  const FaqScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends ConsumerState<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    final fireStoreProvider = ref.watch(firestoreProvider);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "Frequently asked questions",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Grotesk',
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        shadowColor: Colors.black,
        bottomOpacity: 0.1,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            StreamBuilder(
              stream: fireStoreProvider!.firestore.collection("Faqs").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("Have any questions? Contact support"),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var document = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ExpansionTile(
                            title: Text(
                          document['question'],
                          style: const TextStyle(fontFamily: 'Grotesk', fontSize: 20),
                        ),
                        children: [
                          ListTile(
                          title: Text(
                            document['answer'], style: const TextStyle(fontFamily: 'Grotesk', fontSize: 15),
                          ),
                        )
                        ],),
                      );
                    },
                  );
                }
                return const Text("");
              },
            ),
            const SizedBox(height: 40,),
            const Padding(
              padding: EdgeInsets.all(25.0),
              child: Text("Still have an unanswered question? Contact us on the customer service page or call us at 07777777777", style: TextStyle(fontFamily: 'Grotesk', color: Colors.grey),),
            )
          ],
        )),
      ),
    );
  }
}
