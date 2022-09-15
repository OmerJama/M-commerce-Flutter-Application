import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  final String uid;

  StorageService({
    required this.uid,
  });

  FirebaseStorage storage = FirebaseStorage.instance;

  
  Future<String> uploadFile(String filePath) async {
    try {
      final dateTime = DateTime.now()
          .toIso8601String(); //gets todays date and time. Names the image as this.
      final storageLocation =
          storage.ref("$uid/$dateTime"); //Specify the storage location.
      final uploadTask = await storageLocation
          .putFile(File(filePath)); //upload file using path
      return await uploadTask.ref
          .getDownloadURL(); // waits for upload task to finish and gets the downloadable image url from it.
    } catch (e) {
      // ignore: avoid_print
      print(e.toString());
    }

    return "";
  }
}
