import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:social_app/products/constants/index.dart';
import 'package:social_app/products/models/post_model.dart';

import 'package:social_app/products/widgets/image_card.dart';

class LikedPosts extends StatelessWidget {
  const LikedPosts({required this.posts, super.key});
  final Future<QuerySnapshot<Post?>> posts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder(
          future: posts,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
                return const Text(StringConstants.noConnection);
              case ConnectionState.waiting:
              case ConnectionState.active:
                return const CircularProgressIndicator();
              case ConnectionState.done:
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data?.size,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: context.paddingNormal,
                        child: ImageCard(
                          key: PageStorageKey(index),
                          post: snapshot.data?.docs.elementAt(index).data(),
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
            }
          },
        ),
      ),
    );
  }
}
