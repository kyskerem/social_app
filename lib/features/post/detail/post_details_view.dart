// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kartal/kartal.dart';
import 'package:social_app/core/models/post_model.dart';
import 'package:social_app/features/post/comment/post_comments_view.dart';
import 'package:social_app/features/post/like/like_post.dart';
import 'package:social_app/features/post/like/post_likes_view.dart';
import 'package:social_app/products/enums/icon.dart';

class PostDetailView extends StatefulWidget {
  const PostDetailView({
    required this.post,
    super.key,
  });
  final Post post;
  @override
  State<PostDetailView> createState() => _PostDetailViewState();
}

class _PostDetailViewState extends State<PostDetailView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  final tabs = <Tab>[
    Tab(
      icon: SvgPicture.asset(
        IconEnum.like.toSvg,
      ),
    ),
    Tab(
      icon: SvgPicture.asset(IconEnum.comment.toSvg),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: tabs.length, vsync: this);
  }

  Future<void> handleLike() async {
    await likePost(
      widget.post,
      FirebaseAuth.instance.currentUser!,
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final details = <Widget>[
      PostLikesView(
        handleLike: handleLike,
        likes: widget.post.likes,
      ),
      PostCommentsView(post: widget.post)
    ];
    return Scaffold(
      body: Container(
        margin: context.verticalPaddingMedium,
        child: Center(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  showDialog<Widget>(
                    context: context,
                    builder: (context) => InteractiveViewer(
                      child: Image.network(
                        widget.post.postUrl,
                      ),
                    ),
                  );
                },
                child: SizedBox(
                  height: context.dynamicHeight(.3),
                  child: Image.network(
                    widget.post.postUrl,
                  ),
                ),
              ),
              Text(
                widget.post.description,
                style: context.textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              SizedBox(
                height: context.dynamicHeight(.05),
                child: TabBar(
                  controller: _tabController,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: tabs,
                ),
              ),
              Expanded(
                flex: 10,
                child: TabBarView(
                  controller: _tabController,
                  children: details,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
