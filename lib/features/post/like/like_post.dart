// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls, lines_longer_than_80_chars

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/products/enums/firebase_props_enum.dart';
import 'package:social_app/products/models/post_model.dart';
import 'package:social_app/products/utility/firebase/firebase_collections.dart';

Stream<QuerySnapshot<Object?>> getPost(Post post) {
  final dbPost = FirebaseColletions.Posts.reference
      .where(FirebaseProps.id.value, isEqualTo: post.id)
      .get()
      .asStream();

  return dbPost;
}

bool isLiked(Post post, User user) {
  if (post.likes == null) return false;
  for (final like in post.likes!) {
    if (user.uid == like['uid']) {
      return true;
    }
  }
  return false;
}

Future<void> likePost(Post post, User user) async {
  final dbpost = await getPost(post).first;
  final postId = dbpost.docs.first.id;
  if (isLiked(post, user)) {
    post.likes?.removeWhere(
      (element) => element[FirebaseProps.uid.value] == user.uid,
    );
    FirebaseColletions.Posts.reference
        .doc(postId)
        .update(post.toMap(post))
        .asStream();
  } else {
    post.likes?.add({
      FirebaseProps.photoURL.value: user.photoURL,
      FirebaseProps.displayName.value: user.displayName,
      FirebaseProps.uid.value: user.uid
    });

    FirebaseColletions.Posts.reference
        .doc(postId)
        .update(
          post.toMap(
            post,
          ),
        )
        .asStream();
  }
}

Future<void> getPosts() async {
  await FirebaseColletions.Posts.reference.get();
}
