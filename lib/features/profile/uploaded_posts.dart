// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

import 'package:social_app/products/constants/string_constants.dart';
import 'package:social_app/products/models/post_model.dart';
import 'package:social_app/products/widgets/image_card.dart';

class UploadedPosts extends StatelessWidget {
  const UploadedPosts({
    required this.posts,
    required this.deletePost,
    super.key,
  });
  final Stream<QuerySnapshot<Post?>> posts;
  final Future<void> Function(String docId, String postId) deletePost;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: StreamBuilder(
          stream: posts,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text(StringConstants.noConnection);
              case ConnectionState.waiting:
              case ConnectionState.active:
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.size,
                    itemBuilder: (context, index) {
                      final data = snapshot.data?.docs.elementAt(index);
                      return Padding(
                        padding: context.paddingNormal,
                        child: Stack(
                          children: [
                            ImageCard(
                              post: data?.data(),
                            ),
                            if (data?.data()?.publisherUid ==
                                FirebaseAuth.instance.currentUser?.uid)
                              Positioned(
                                right: 30,
                                child: IconButton(
                                  onPressed: () async {
                                    await deletePost(
                                      data?.id ?? '',
                                      data?.data()?.postId ?? '',
                                    );
                                  },
                                  icon: const Icon(Icons.delete_forever),
                                ),
                              )
                            else
                              const SizedBox()
                          ],
                        ),
                      );
                    },
                  );
                }
                if (snapshot.hasError) {
                  return const Text(StringConstants.error);
                } else {
                  return const Text(StringConstants.noPosts);
                }
              case ConnectionState.done:
                return const CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}
