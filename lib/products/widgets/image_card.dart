import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:social_app/core/models/post_model.dart';
import 'package:social_app/features/post/detail/post_details_view.dart';
import 'package:social_app/features/post/like/like_post.dart';
import 'package:social_app/products/constants/colors_contants.dart';
import 'package:social_app/products/constants/string_constants.dart';
import 'package:social_app/products/enums/icon.dart';
import 'package:social_app/products/utility/exceptions/firebase_exception.dart';
import 'package:social_app/products/widgets/footer_card.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    required this.post,
    super.key,
  });
  final Post? post;
  Future<void> like() async {
    final curUser = FirebaseAuth.instance.currentUser;
    if (curUser == null) {
      throw const FbCustomException(error: StringConstants.noNullUser);
    }

    await likePost(
      post!,
      curUser,
    );
  }

  void goToPostDetails(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute<Widget>(
        builder: (context) => PostDetailView(post: post!),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (post == null) {
      throw const FbCustomException(error: StringConstants.noNullPost);
    }
    return Container(
      margin: context.horizontalPaddingMedium,
      decoration: BoxDecoration(
        color: ColorConstants.black,
        borderRadius: context.normalBorderRadius,
        image: DecorationImage(
          fit: BoxFit.fitHeight,
          image: NetworkImage(
            post?.postUrl ?? '',
          ),
        ),
      ),
      constraints: BoxConstraints(
        maxHeight: context.dynamicHeight(.4),
      ),
      child: InkWell(
        splashColor: ColorConstants.transparent,
        onDoubleTap: () async {
          await like();
        },
        onTap: post != null
            ? () {
                goToPostDetails(context);
              }
            : null,
        child: Stack(
          alignment: Alignment.topLeft,
          fit: StackFit.expand,
          children: [
            _FooterRow(post: post),
          ],
        ),
      ),
    );
  }
}

class _FooterRow extends StatelessWidget {
  const _FooterRow({
    required this.post,
  });

  final Post? post;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        FooterCard(
          post: post!,
          count: post?.likes?.length ?? 0,
          icon: IconEnum.like,
        ),
        FooterCard(
          post: post!,
          count: post!.comments?.length ?? 0,
          icon: IconEnum.comment,
        ),
      ],
    );
  }
}
