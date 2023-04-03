// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/models/post_model.dart';
import 'package:social_app/products/widgets/post_streambuilder.dart';

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
        child: PostStreamBuilder(
          isImageCard: true,
          stream: posts,
          deletePost: deletePost,
        ),
      ),
    );
  }
}
