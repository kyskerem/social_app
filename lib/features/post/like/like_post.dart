// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls

import 'package:firebase_auth/firebase_auth.dart';
import 'package:social_app/products/enums/firebase_props_enum.dart';
import 'package:social_app/products/models/post_model.dart';
import 'package:social_app/products/utility/firebase/firebase_collections.dart';

Future<String> getPostId(Post post) {
  final dbPost = FirebaseColletions.Posts.reference
      .where(FirebaseProps.id.value, isEqualTo: post.id)
      .limit(1)
      .snapshots();

  return dbPost.elementAt(0).then(
        (value) => value.docs.first.id,
      );
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
  final postId = await getPostId(post);

  if (isLiked(post, user)) {
    post.likes?.removeWhere(
      (element) => element[FirebaseProps.uid.value] == user.uid,
    );
    await FirebaseColletions.Posts.reference
        .doc(postId)
        .update(post.toMap(post));
  } else {
    post.likes?.add({
      FirebaseProps.photoURL.value: user.photoURL,
      FirebaseProps.displayName.value: user.displayName,
      FirebaseProps.uid.value: user.uid
    });

    await FirebaseColletions.Posts.reference.doc(postId).update(
          post.toMap(
            post,
          ),
        );
  }
}

Future<void> getPosts() async {
  await FirebaseColletions.Posts.reference.get();
}
