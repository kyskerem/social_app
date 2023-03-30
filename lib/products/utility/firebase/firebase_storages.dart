// ignore_for_file: constant_identifier_names

import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

enum FirebaseStorages {
  Defaults,
  Posts;

  Reference get reference => FirebaseStorage.instance.ref(name);

  Future<void> upload(String fileName, File file, {String? uid}) {
    if (uid == null) throw Exception();
    return FirebaseStorage.instance
        .ref(name)
        .child(uid)
        .child(fileName)
        .putFile(file);
  }
}
