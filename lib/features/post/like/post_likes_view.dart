// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls, lines_longer_than_80_chars
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:social_app/products/enums/firebase_props_enum.dart';
import 'package:social_app/products/enums/image/image.dart';
import 'package:social_app/products/widgets/profile_photo.dart';

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
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: likes?.length ?? 0,
          itemBuilder: (context, index) {
            return ListTile(
              leading: ProfilePhoto(
                redirect: true,
                profilePhotoUrl: likes
                    ?.elementAt(index)[FirebaseProps.photoURL.value] as String,
                profileUid:
                    likes?.elementAt(index)[FirebaseProps.uid.value] as String,
              ),
              title: Text(
                likes?.elementAt(
                  index,
                )[FirebaseProps.displayName.value] as String,
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: handleLike,
        child: SvgPicture.asset(IconEnum.like.toSvg),
      ),
    );
  }
}
