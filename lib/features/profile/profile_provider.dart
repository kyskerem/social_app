// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/products/enums/firebase_props_enum.dart';
import 'package:social_app/products/models/post_model.dart';
import 'package:social_app/products/utility/firebase/firebase_collections.dart';
import 'package:social_app/products/utility/firebase/firebase_storages.dart';

class ProfileProvider extends StateNotifier<ProfileState> {
  ProfileProvider() : super(const ProfileState());

  Stream<QuerySnapshot<Post?>> fetchLikedPosts(
    String? uid,
    String photoURL,
    String displayName,
  ) {
    return FirebaseColletions.Posts.reference.where(
      FirebaseProps.likes.value,
      arrayContains: {
        FirebaseProps.displayName.value: displayName,
        FirebaseProps.photoURL.value: photoURL,
        FirebaseProps.uid.value: uid
      },
    ).withConverter<Post>(
      fromFirestore: (snapshot, options) {
        return Post.fromJson(snapshot.data() ?? {});
      },
      toFirestore: (value, options) {
        return value.toMap(value);
      },
    ).snapshots();
  }

  Stream<QuerySnapshot<Post?>> fetchUploadedPosts(
    String? publisherUid,
  ) {
    final posts = FirebaseColletions.Posts.reference
        .where(FirebaseProps.publisherUid.value, isEqualTo: publisherUid)
        .withConverter<Post>(
      fromFirestore: (snapshot, options) {
        return Post.fromJson(snapshot.data() ?? {});
      },
      toFirestore: (value, options) {
        return value.toMap(value);
      },
    ).snapshots();

    return posts;
  }

  Future<void> deletePost(
    String? docId,
    String postId,
  ) async {
    final curUser = FirebaseAuth.instance.currentUser;
    if (curUser == null) return;
    {
      await FirebaseColletions.Posts.reference.doc(docId).delete();
    }
    await FirebaseStorages.Posts.reference
        .child(curUser.uid)
        .child(postId)
        .delete();
  }
}

@immutable
class ProfileState {
  const ProfileState();
}
