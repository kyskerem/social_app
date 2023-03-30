// ignore_for_file: public_member_api_docs, sort_constructors_first, avoid_dynamic_calls
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:social_app/features/post/like/like_post.dart';
import 'package:social_app/products/enums/firebase_props_enum.dart';
import 'package:social_app/products/enums/image/image.dart';
import 'package:social_app/products/models/post_model.dart';
import 'package:social_app/products/utility/firebase/firebase_collections.dart';
import 'package:social_app/products/widgets/profile_photo.dart';

class PostLikesView extends ConsumerStatefulWidget {
  const PostLikesView({
    required this.postId,
    super.key,
  });
  final String postId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _PostLikesViewState();
}

class _PostLikesViewState extends ConsumerState<PostLikesView> {
  @override
  void initState() {
    super.initState();
  }

  Stream<QuerySnapshot<Post>> get post => FirebaseColletions.Posts.reference
      .where(FirebaseProps.postId.value, isEqualTo: widget.postId)
      .withConverter<Post>(
        fromFirestore: (snapshot, options) {
          return Post.fromJson(snapshot.data() ?? {});
        },
        toFirestore: (value, options) {
          return value.toMap(value);
        },
      )
      .get()
      .asStream();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: StreamBuilder(
            stream: post,
            builder: (context, snapshot) {
              final data = snapshot.data?.docs.first.data();
              return ListView.builder(
                itemCount: data?.likes?.length ?? 0,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: ProfilePhoto(
                      profilePhotoUrl: data?.likes
                              ?.elementAt(index)[FirebaseProps.photoURL.value]
                          as String,
                      profileUid: data?.likes
                          ?.elementAt(index)[FirebaseProps.uid.value] as String,
                    ),
                    title: Text(
                      data?.likes?.elementAt(
                        index,
                      )[FirebaseProps.displayName.value] as String,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final postToLike = await post.first.then((value) => value);
          await likePost(
            postToLike.docs.first.data(),
            FirebaseAuth.instance.currentUser!,
          );
          setState(() {});
        },
        child: SvgPicture.asset(IconEnum.like.toSvg),
      ),
    );
  }
}
