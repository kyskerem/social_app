// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls, lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:social_app/products/enums/icon.dart';
import 'package:social_app/products/widgets/like_or_comment_list.dart';

class PostLikesView extends StatelessWidget {
  const PostLikesView({
    required this.likes,
    required this.handleLike,
    super.key,
  });
  final List<dynamic>? likes;
  final Future<void> Function() handleLike;
  @override
  Widget build(BuildContext context) {
    return LikeOrCommentListView(
      likeOrCommentSvg: IconEnum.like,
      likesOrComments: likes,
      handleLikeOrComment: handleLike,
    );
  }
}
