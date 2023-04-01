import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:social_app/features/post/detail/post_details_view.dart';
import 'package:social_app/features/post/like/like_post.dart';
import 'package:social_app/products/constants/string_constants.dart';
import 'package:social_app/products/enums/image/image.dart';
import 'package:social_app/products/models/post_model.dart';
import 'package:social_app/products/utility/exceptions/firebase_exception.dart';
import 'package:social_app/products/widgets/footer_card.dart';

class ImageCard extends StatelessWidget {
  const ImageCard({
    required this.post,
    super.key,
  });
  final Post? post;
  @override
  Widget build(BuildContext context) {
    if (post == null) {
      throw const FbCustomException(error: StringConstants.noNullPost);
    }
    return Container(
      margin: context.horizontalPaddingMedium,
      decoration: BoxDecoration(
        color: Colors.black,
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
        splashColor: Colors.transparent,
        onDoubleTap: () {
          final curUser = FirebaseAuth.instance.currentUser;
          if (curUser == null) {
            throw const FbCustomException(error: StringConstants.noNullUser);
          }

          likePost(
            post!,
            curUser,
          );
        },
        onTap: post != null
            ? () {
                Navigator.push(
                  context,
                  MaterialPageRoute<Widget>(
                    builder: (context) => PostDetailView(post: post!),
                  ),
                );
              }
            : null,
        child: Stack(
          alignment: Alignment.topLeft,
          fit: StackFit.expand,
          children: [
            Row(
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
            ),
          ],
        ),
      ),
    );
  }
}
