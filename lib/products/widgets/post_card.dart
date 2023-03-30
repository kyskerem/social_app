import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:social_app/products/constants/index.dart';
import 'package:social_app/products/models/post_model.dart';
import 'package:social_app/products/widgets/image_card.dart';
import 'package:social_app/products/widgets/profile_photo.dart';

class PostCard extends StatelessWidget {
  const PostCard({
    required this.index,
    required this.posts,
    super.key,
  });
  final int index;
  final List<QueryDocumentSnapshot<Post?>>? posts;
  @override
  Widget build(BuildContext context) {
    final post = posts?[index].data();
    if (post == null) return const Text(StringConstants.noPost);
    return Column(
      children: [
        Card(
          color: Colors.transparent,
          margin: context.paddingNormal,
          child: ListTile(
            leading: ProfilePhoto(
              profilePhotoUrl: post.publisherProfileImage,
              profileUid: post.publisherUid,
            ),
            title: Text(
              post.publisherName,
              style: context.textTheme.bodyLarge,
              textAlign: TextAlign.justify,
            ),
            subtitle: Padding(
              padding: context.paddingLow,
              child: Text(
                post.description,
                style: context.textTheme.bodySmall,
                textAlign: TextAlign.start,
              ),
            ),
          ),
        ),
        ImageCard(
          post: post,
        ),
      ],
    );
  }
}
