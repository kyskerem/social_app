// ignore_for_file: strict_raw_type, avoid_dynamic_calls

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/products/enums/firebase_props_enum.dart';
import 'package:social_app/products/enums/icon.dart';
import 'package:social_app/products/widgets/profile_photo.dart';

class LikeOrCommentListView extends StatelessWidget {
  const LikeOrCommentListView({
    required this.likesOrComments,
    required this.likeOrCommentSvg,
    required this.handleLikeOrComment,
    super.key,
  });

  final List? likesOrComments;
  final Future<void> Function() handleLikeOrComment;
  final IconEnum likeOrCommentSvg;
  bool get isComment => likeOrCommentSvg == IconEnum.comment;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: likesOrComments?.length ?? 0,
          itemBuilder: (context, index) {
            final item = likesOrComments?.elementAt(index);
            return ListTile(
              leading: ProfilePhoto(
                redirect: true,
                profilePhotoUrl: item[FirebaseProps.photoURL.value] as String,
                profileUid: item[FirebaseProps.uid.value] as String,
              ),
              title: Text(item[FirebaseProps.displayName.value] as String),
              subtitle: isComment
                  ? Text(item[FirebaseProps.comment.value] as String)
                  : const SizedBox(),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleLikeOrComment,
        child: SvgPicture.asset(likeOrCommentSvg.toSvg),
      ),
    );
  }
}
