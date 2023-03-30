import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/products/enums/firebase_props_enum.dart';
import 'package:social_app/products/models/post_model.dart';
import 'package:social_app/products/utility/firebase/firebase_collections.dart';

class CommentNotifier extends StateNotifier<CommentState> {
  CommentNotifier() : super(CommentState());
}

@immutable
class CommentState {}

Future<String> getPostId(Post post) async {
  final dbPost = FirebaseColletions.Posts.reference
      .where(FirebaseProps.id.value, isEqualTo: post.id)
      .limit(1)
      .snapshots();

  return dbPost.elementAt(0).then(
        (value) => value.docs.first.id,
      );
}

Future<void> commentToPost(Post post, User user, String comment) async {
  final postId = await getPostId(post);

  post.comments?.add({
    FirebaseProps.comment.value: comment,
    FirebaseProps.photoURL.value: user.photoURL,
    FirebaseProps.displayName.value: user.displayName,
    FirebaseProps.uid.value: user.uid
  });

  await FirebaseColletions.Posts.reference.doc(postId).update(post.toMap(post));
}
