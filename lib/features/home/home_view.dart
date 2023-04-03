// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/features/home/home_provider.dart';
import 'package:social_app/products/widgets/post_streambuilder.dart';

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
          child: PostStreamBuilder(
            isImageCard: false,
            stream: homeProvider.fetchPosts(),
          ),
        ),
      ),
    );
  }
}
