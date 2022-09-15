import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/providers/providers.dart';

class ViewUsersScreen extends ConsumerStatefulWidget {
  const ViewUsersScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ViewUsersScreen> createState() => _ViewUsersScreenState();
}

class _ViewUsersScreenState extends ConsumerState<ViewUsersScreen> {
  @override
  Widget build(BuildContext context) {
    final fireStoreProvider = ref.watch(firestoreProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your users"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
            child: Column(
          children: [
            StreamBuilder(
              stream:
                  fireStoreProvider!.firestore.collection("users").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.docs.isEmpty) {
                    return const Text("No users yet!");
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final document = snapshot.data!.docs[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(8),
                          tileColor: Colors.white,
                          title: Text("${document['firstName']} ${document['secondName']}", style: const TextStyle(fontFamily: 'Grotesk', fontWeight: FontWeight.bold),),
                          subtitle: StreamBuilder(
                            stream: fireStoreProvider.firestore.collection("Orders").where('uid', isEqualTo: document['uid']).where('cancelled', isEqualTo: 'false').snapshots(),
                            builder: (context, snapshotTwo) {
                            if (snapshotTwo.hasData) {
                              if (snapshotTwo.data!.docs.isEmpty) {
                                return Text("${document['email']}\nNo purchases");
                              }
                              double totalSpent = 0;
                              for(int x = 0; x< snapshotTwo.data!.docs.length; x++){
                                totalSpent = totalSpent + snapshotTwo.data!.docs[x]['totalprice'];
                              }
                              return Text("${document['email']}\nAmount spent £${totalSpent.toStringAsFixed(2)}");
                            }
                            return const Text("");
                          },),
                        ),
                      );
                    },
                  );
                }
                return const Text("");
              },
              
            )
          ],
        )),
      ),
    );
  }
}
