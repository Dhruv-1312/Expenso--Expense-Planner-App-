import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class StorageMethods {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> uploadImage(
      String childname, Uint8List file, bool isBill) async {
    Reference ref = _storage
        .ref()
        .child(childname)
        .child(FirebaseAuth.instance.currentUser!.uid);

    if (isBill) {
      String id = Uuid().v1();
      ref = ref.child(
          id); // this will create a folder with current user uid as its name in the bill folder
    }

    UploadTask upload = ref.putData(file);

    TaskSnapshot snap = await upload;
    String downloadURL = await snap.ref.getDownloadURL();
    return downloadURL;
  }
}
