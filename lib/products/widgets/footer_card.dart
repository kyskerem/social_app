import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:social_app/core/models/post_model.dart';
import 'package:social_app/features/post/detail/post_details_view.dart';
import 'package:social_app/features/post/like/like_post.dart';
import 'package:social_app/products/constants/index.dart';
import 'package:social_app/products/enums/icon.dart';
import 'package:social_app/products/utility/exceptions/firebase_exception.dart';

class FooterCard extends StatelessWidget {
  FooterCard({
    required int count,
    required IconEnum icon,
    required Post post,
    super.key,
  }) {
    _count = count;
    _icon = icon;
    _post = post;
  }
  late final int _count;
  late final IconEnum _icon;
  late final Post _post;
  bool get isLike => _icon == IconEnum.like;
  void like() {
    final curUser = FirebaseAuth.instance.currentUser;
    if (curUser == null) {
      throw const FbCustomException(error: StringConstants.noNullUser);
    }
    likePost(
      _post,
      curUser,
    );
  }

  void goToPostDetails(BuildContext context) {
    context.navigateToPage(PostDetailView(post: _post));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        isLike ? like() : goToPostDetails(context);
      },
      child: Card(
        child: _FooterIconAndText(icon: _icon, count: _count),
      ),
    );
  }
}

class _FooterIconAndText extends StatelessWidget {
  const _FooterIconAndText({
    required IconEnum icon,
    required int count,
  })  : _icon = icon,
        _count = count;

  final IconEnum _icon;
  final int _count;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 5,
      children: [
        Padding(
          padding: context.verticalPaddingLow,
          child: SvgPicture.asset(
            _icon.toSvg,
            height: context.normalValue,
          ),
        ),
        Padding(
          padding: context.paddingLow,
          child: Text(
            '$_count',
            textAlign: TextAlign.center,
            textScaleFactor: 1.125,
            style: context.textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w300,
              color: ColorConstants.white,
            ),
          ),
        )
      ],
    );
  }
}
