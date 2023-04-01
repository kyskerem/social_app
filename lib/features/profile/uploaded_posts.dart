import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:social_app/products/constants/string_constants.dart';
import 'package:social_app/products/models/post_model.dart';
import 'package:social_app/products/widgets/image_card.dart';

class UploadedPosts extends StatelessWidget {
  const UploadedPosts({required this.posts, super.key});
  final Stream<QuerySnapshot<Post?>> posts;
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
                        child: ImageCard(
                          post: data?.data(),
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
