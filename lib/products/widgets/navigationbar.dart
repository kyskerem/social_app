import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class ProjectNavigationBar extends StatelessWidget {
  ProjectNavigationBar({
    required TabController controller,
    super.key,
  }) {
    _controller = controller;
  }
  late final TabController _controller;
  final List<Tab> _tabs = [
    const Tab(
      icon: Icon(Icons.home_rounded),
    ),
    const Tab(
      icon: Icon(Icons.person_rounded),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: _controller,
      labelPadding: context.paddingLow,
      tabs: _tabs,
    );
  }
}
