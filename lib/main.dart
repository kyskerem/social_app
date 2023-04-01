import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/features/auth/authentication_view.dart';
import 'package:social_app/features/post/upload/upload_view.dart';
import 'package:social_app/navigation_view.dart';
import 'package:social_app/products/constants/string_constants.dart';
import 'package:social_app/products/enums/route_enum.dart';
import 'package:social_app/products/initialize/app_init.dart';
import 'package:social_app/products/themes/themes.dart';

void main() async {
  await ApplicationInit.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: StringConstants.appName,
      theme: ProjectTheme.lightTheme,
      darkTheme: ProjectTheme.darkTheme,
      routes: {
        RouteEnum.root.route: (context) => const AuthenticationView(),
        RouteEnum.home.route: (context) => const NavigationView(),
        RouteEnum.upload.route: (context) => const UploadView(),
      },
    );
  }
}
