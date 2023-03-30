import 'package:flutter/material.dart';

enum RouteEnum {
  root('/'),
  home('Home'),
  upload('Upload');

  final String route;
  const RouteEnum(this.route);

  Future<Object?> popAndPush(BuildContext context) =>
      Navigator.popAndPushNamed(context, route);
  Future<Object?> push(BuildContext context) =>
      Navigator.pushNamed(context, route);
}
