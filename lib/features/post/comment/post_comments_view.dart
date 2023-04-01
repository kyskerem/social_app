// ignore_for_file: avoid_dynamic_calls

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:social_app/features/post/comment/comment_provider.dart';
import 'package:social_app/products/constants/string_constants.dart';
import 'package:social_app/products/enums/firebase_props_enum.dart';
import 'package:social_app/products/enums/image/image.dart';
import 'package:social_app/products/models/post_model.dart';
import 'package:social_app/products/widgets/profile_photo.dart';

class PostCommentsView extends StatelessWidget {
  PostCommentsView({
    required this.post,
    super.key,
  });
  final _commentController = TextEditingController();

  final Post? post;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        separatorBuilder: (context, index) => const Divider(),
        itemCount: post?.comments?.length ?? 0,
        itemBuilder: (context, index) {
          return Padding(
            padding: context.verticalPaddingLow,
            child: ListTile(
              leading: ProfilePhoto(
                redirect: true,
                profilePhotoUrl: post?.comments
                    ?.elementAt(index)[FirebaseProps.photoURL.value] as String,
                profileUid: post?.comments
                    ?.elementAt(index)[FirebaseProps.uid.value] as String,
              ),
              title: Text(
                post?.comments?.elementAt(index)[FirebaseProps.comment.value]
                    as String,
                textAlign: TextAlign.start,
                style: context.textTheme.bodyLarge,
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog<AlertDialog>(
            context: context,
            builder: (context) => AlertDialog(
              content: TextField(
                controller: _commentController,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () async {
                    await commentToPost(
                      post!,
                      FirebaseAuth.instance.currentUser!,
                      _commentController.text,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text(StringConstants.comment),
                )
              ],
            ),
          );
        },
        child: SvgPicture.asset(IconEnum.comment.toSvg),
      ),
    );
  }
}
