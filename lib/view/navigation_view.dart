// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/features/auth/authentication_providers.dart';
import 'package:social_app/features/home/home_view.dart';
import 'package:social_app/features/profile/profile_view.dart';
import 'package:social_app/products/constants/index.dart';
import 'package:social_app/products/utility/exceptions/firebase_exception.dart';
import 'package:social_app/products/widgets/appbar.dart';
import 'package:social_app/products/widgets/fab_button.dart';
import 'package:social_app/products/widgets/navigationbar.dart';

class NavigationView extends StatefulWidget {
  const NavigationView({
    super.key,
  });
  @override
  State<NavigationView> createState() => _NavigationViewState();
}

class _NavigationViewState extends State<NavigationView>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  late final List<Widget> _views;
  final _authProvider = AuthenticationProvider();
  @override
  void initState() {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw const FbCustomException(error: StringConstants.noNullUser);
    }
    _authProvider.saveUserToDatabase(user);
    user.reload();
    _views = <Widget>[
      const HomeView(),
      ProfileView(
        user: user,
      )
    ];

    _tabController = TabController(
      length: _views.length,
      vsync: this,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ProjectAppBar(
        context: context,
      ),
      body: TabBarView(
        controller: _tabController,
        children: _views,
      ),
      floatingActionButton: ProjectFabButton(
        context: context,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: ProjectNavigationBar(
        controller: _tabController,
      ),
    );
  }
}
