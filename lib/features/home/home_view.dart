// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:social_app/features/home/home_provider.dart';
import 'package:social_app/products/constants/index.dart';
import 'package:social_app/products/models/post_model.dart';
import 'package:social_app/products/widgets/post_card.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final homeProvider = HomeProvider();

  @override
  void initState() {
    super.initState();
  }

  Future<void> refreshPosts() async {
    homeProvider.fetchPosts();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: refreshPosts,
        child: SafeArea(
          child: StreamBuilder<QuerySnapshot<Post>>(
            stream: homeProvider.fetchPosts(),
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                  return const Text(StringConstants.noConnection);
                case ConnectionState.waiting:
                case ConnectionState.done:
                  return const Center(child: CircularProgressIndicator());
                case ConnectionState.active:
                  if (snapshot.hasData) {
                    final data = snapshot.data;
                    return ListView.separated(
                      separatorBuilder: (context, index) => const Divider(),
                      itemCount: data?.docs.length ?? 0,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: context.onlyTopPaddingNormal,
                          child: PostCard(
                            post: data?.docs[index].data(),
                          ),
                        );
                      },
                    );
                  } else {
                    return Center(
                      child: Text(
                        StringConstants.noPost,
                        style: context.textTheme.headlineSmall,
                      ),
                    );
                  }
              }
            },
          ),
        ),
      ),
    );
  }
}
