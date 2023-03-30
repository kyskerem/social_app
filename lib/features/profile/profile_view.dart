// ignore_for_file: avoid_dynamic_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:social_app/features/profile/liked_posts.dart';
import 'package:social_app/features/profile/profile_provider.dart';
import 'package:social_app/features/profile/uploaded_posts.dart';
import 'package:social_app/products/constants/string_constants.dart';
import 'package:social_app/products/enums/firebase_props_enum.dart';
import 'package:social_app/products/models/post_model.dart';
import 'package:social_app/products/utility/exceptions/firebase_exception.dart';
import 'package:social_app/products/widgets/profile_photo.dart';

class ProfileView extends ConsumerStatefulWidget {
  ProfileView({required this.user, super.key}) {
    user ??= FirebaseAuth.instance.currentUser;
  }
  late final dynamic user;
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProfileViewState();
}

class _ProfileViewState extends ConsumerState<ProfileView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final profileProvider =
      StateNotifierProvider<ProfileProvider, ProfileState>((ref) {
    return ProfileProvider();
  });

  late final Future<QuerySnapshot<Post?>> likedPosts;
  late final Future<QuerySnapshot<Post?>> uploadedPosts;
  late final String photo;
  late final String userName;
  late final String uid;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    if (widget.user is User) {
      photo = widget.user.photoURL as String;
      userName = widget.user.displayName as String;
      uid = widget.user.uid as String;
      likedPosts = ref.read(profileProvider.notifier).fetchLikedPosts(
            uid,
            photo,
            userName,
          );
      uploadedPosts =
          ref.read(profileProvider.notifier).fetchUploadedPosts(uid);
    } else if (widget.user is Map) {
      photo = widget.user[FirebaseProps.photoURL.value] as String;
      userName = widget.user[FirebaseProps.displayName.value] as String;
      uid = widget.user[FirebaseProps.uid.value] as String;
      likedPosts = ref.read(profileProvider.notifier).fetchLikedPosts(
            uid,
            photo,
            userName,
          );
      uploadedPosts =
          ref.read(profileProvider.notifier).fetchUploadedPosts(uid);
    } else {
      throw const FbCustomException(error: StringConstants.userIsntCorrectType);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Wrap(
              direction: Axis.vertical,
              crossAxisAlignment: WrapCrossAlignment.center,
              spacing: 20,
              children: [
                ProfilePhoto(
                  profilePhotoUrl: photo,
                  profileUid: uid,
                ),
                Text(
                  userName,
                  style: context.textTheme.bodyMedium,
                ),
              ],
            ),
            TabBar(
              controller: _tabController,
              indicator: const BoxDecoration(),
              tabs: const [
                Tab(icon: Icon(Icons.video_call)),
                Tab(icon: Icon(Icons.heart_broken)),
              ],
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  UploadedPosts(posts: uploadedPosts),
                  LikedPosts(posts: likedPosts),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
