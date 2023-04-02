// ignore_for_file: lines_longer_than_80_chars

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_app/core/models/post_model.dart';
import 'package:social_app/products/utility/firebase/firebase_collections.dart';
import 'package:social_app/products/utility/firebase/firebase_storages.dart';
import 'package:uuid/uuid.dart';

Future<void> uploadPostToDatabase(Post post, XFile image) async {
  final uuid = const Uuid().v4();
  await uploadPostToStorage(image, uuid);

  final toPost = post.copyWith(
    postId: uuid,
    postUrl:
        '${dotenv.env['STORAGE_POST_BASE_URL']}${FirebaseAuth.instance.currentUser?.uid}%2f$uuid${dotenv.env['STORAGE_URL_LAST']}',
  );

  await FirebaseColletions.Posts.reference.add(post.toMap(toPost));
}

Future<void> uploadPostToStorage(XFile image, String uuid) async {
  await FirebaseStorages.Posts.upload(
    uuid,
    File(image.path),
    uid: FirebaseAuth.instance.currentUser?.uid,
  );
}
