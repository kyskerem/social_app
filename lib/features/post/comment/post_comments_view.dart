// ignore_for_file: avoid_dynamic_calls

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/core/models/post_model.dart';
import 'package:social_app/features/post/comment/comment_provider.dart';
import 'package:social_app/products/constants/string_constants.dart';
import 'package:social_app/products/enums/icon.dart';

import 'package:social_app/products/widgets/like_or_comment_list.dart';

class PostCommentsView extends StatelessWidget {
  PostCommentsView({
    required this.post,
    super.key,
  });
  final _commentController = TextEditingController();

  final Post? post;
  final _notifier = CommentNotifier();
  Future<void> handleComment(BuildContext context) async {
    await showDialog<AlertDialog>(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          maxLength: 240,
          controller: _commentController,
        ),
        actions: [
          ElevatedButton(
            onPressed: () async {
              await _notifier
                  .commentToPost(
                    post!,
                    FirebaseAuth.instance.currentUser!,
                    _commentController.text,
                  )
                  .whenComplete(() => Navigator.pop(context));
            },
            child: const Text(StringConstants.comment),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LikeOrCommentListView(
      likesOrComments: post?.comments,
      likeOrCommentSvg: IconEnum.comment,
      handleLikeOrComment: () async {
        await handleComment(context);
      },
    );
  }
}
