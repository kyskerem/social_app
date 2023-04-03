import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'package:social_app/core/models/post_model.dart';

import 'package:social_app/products/constants/string_constants.dart';
import 'package:social_app/products/utility/exceptions/firebase_exception.dart';

import 'package:social_app/products/widgets/image_card.dart';
import 'package:social_app/products/widgets/post_card.dart';

class PostStreamBuilder extends StatelessWidget {
  const PostStreamBuilder({
    required this.stream,
    required this.isImageCard,
    this.deletePost,
    super.key,
  });

  final Stream<QuerySnapshot<Post?>> stream;
  final Future<void> Function(String docId, String postId)? deletePost;
  final bool isImageCard;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: stream,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            return const Text(StringConstants.noConnection);
          case ConnectionState.waiting:
          case ConnectionState.done:
            return const CircularProgressIndicator();
          case ConnectionState.active:
            if (snapshot.hasData) {
              return _HasDataWidget(
                deletePost: deletePost,
                snapshot: snapshot,
                isImagecard: isImageCard,
              );
            }
            if (snapshot.hasError) {
              return const Text(StringConstants.error);
            } else {
              return const Text(StringConstants.noPosts);
            }
        }
      },
    );
  }
}

class _HasDataWidget extends StatelessWidget {
  const _HasDataWidget({
    required this.snapshot,
    required this.deletePost,
    required this.isImagecard,
  });
  final AsyncSnapshot<QuerySnapshot<Post?>> snapshot;
  final Future<void> Function(String docId, String postId)? deletePost;
  final bool isImagecard;
  Widget card(Post post) =>
      isImagecard ? ImageCard(post: post) : PostCard(post: post);

  Widget deleteButton(QueryDocumentSnapshot<Post?>? data) {
    if (data?.data()?.publisherUid == FirebaseAuth.instance.currentUser?.uid &&
        deletePost != null) {
      return Positioned(
        right: 30,
        child: IconButton(
          onPressed: () async {
            await deletePost!(
              data?.id ?? '',
              data?.data()?.postId ?? '',
            );
          },
          icon: const Icon(Icons.delete_forever),
        ),
      );
    } else {
      return const SizedBox();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: snapshot.data?.size,
      itemBuilder: (context, index) {
        final data = snapshot.data?.docs.elementAt(index);
        final post = data?.data();
        if (post == null) {
          throw const FbCustomException(error: StringConstants.noNullPost);
        }
        return Padding(
          padding: context.paddingNormal,
          child: Stack(
            children: [card(post), deleteButton(data)],
          ),
        );
      },
    );
  }
}
