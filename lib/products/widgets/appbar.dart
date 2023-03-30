import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_app/products/constants/index.dart';

class ProjectAppBar extends AppBar {
  ProjectAppBar({required BuildContext context, super.key})
      : super(
          title: Text(
            StringConstants.appName,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          actions: [
            IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(Icons.exit_to_app),
            )
          ],
        );
}
