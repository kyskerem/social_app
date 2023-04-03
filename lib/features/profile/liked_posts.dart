import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/models/post_model.dart';
import 'package:social_app/products/widgets/post_streambuilder.dart';

class LikedPosts extends StatelessWidget {
  const LikedPosts({required this.posts, super.key});
  final Stream<QuerySnapshot<Post?>> posts;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: PostStreamBuilder(
          stream: posts,
          isImageCard: false,
        ),
      ),
    );
  }
}
