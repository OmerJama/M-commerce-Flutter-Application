import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_app/providers/providers.dart';

class LowStockBody extends ConsumerStatefulWidget {
  final dynamic dropdownValue;
  const LowStockBody({required this.dropdownValue, Key? key}) : super(key: key);

  @override
  ConsumerState<LowStockBody> createState() => _LowStockBodyState();
}

class _LowStockBodyState extends ConsumerState<LowStockBody> {
  @override
  Widget build(BuildContext context) {
    final fireStoreProvider = ref.read(firestoreProvider);
    if (widget.dropdownValue == "Low small stock") {
      return StreamBuilder(
        stream: fireStoreProvider!.firestore
            .collection("Products")
            .where('Small stock', isLessThan: 20)
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const CircularProgressIndicator();
            } 
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var document = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text(document['name']),
                    subtitle: Text("Stock left: ${document['Small stock']}"),
                    trailing: ClipRRect(
                      child: CachedNetworkImage(imageUrl: document['ImageUrl'], height: 100, width: 100, fit: BoxFit.fill,),
                    ),
                  ),
                );
              },
            );
          }
          return const Text("");
        },
      );
    }
    if (widget.dropdownValue == "Low medium stock") {
      return StreamBuilder(
        stream: fireStoreProvider!.firestore
            .collection("Products")
            .where('Medium stock', isLessThan: 20)
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const CircularProgressIndicator();
            } 
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var document = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text(document['name']),
                    subtitle: Text("Stock left: ${document['Medium stock']}"),
                    trailing: ClipRRect(
                      child: CachedNetworkImage(imageUrl: document['ImageUrl'], height: 100, width: 100, fit: BoxFit.fill,),
                    ),
                  ),
                );
              },
            );
          }
          return const Text("");
        },
      );
    }
    if (widget.dropdownValue == "Low large stock") {
      return StreamBuilder(
        stream: fireStoreProvider!.firestore
            .collection("Products")
            .where('Large stock', isLessThan: 20)
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const CircularProgressIndicator();
            } 
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var document = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text(document['name']),
                    subtitle: Text("Stock left: ${document['Large stock']}"),
                    trailing: ClipRRect(
                      child: CachedNetworkImage(imageUrl: document['ImageUrl'], height: 100, width: 100, fit: BoxFit.fill,),
                    ),
                  ),
                );
              },
            );
          }
          return const Text("");
        },
      );
    }
    if (widget.dropdownValue == "Low X large stock") {
      return StreamBuilder(
        stream: fireStoreProvider!.firestore
            .collection("Products")
            .where('X Large stock', isLessThan: 20)
            .snapshots(),
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.waiting)
            {
              return const CircularProgressIndicator();
            } 
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var document = snapshot.data!.docs[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    tileColor: Colors.white,
                    title: Text(document['name']),
                    subtitle: Text("Stock left: ${document['X Large stock']}"),
                    trailing: ClipRRect(
                      child: CachedNetworkImage(imageUrl: document['ImageUrl'], height: 100, width: 100, fit: BoxFit.fill,),
                    ),
                  ),
                );
              },
            );
          }
          return const Text("");
        },
      );
    }
    return Container();
  }
}
