import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:social_app/features/auth/authentication_providers.dart';

import 'package:social_app/view/navigation_view.dart';

class AuthenticationView extends ConsumerStatefulWidget {
  const AuthenticationView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthenticationViewState();
}

class _AuthenticationViewState extends ConsumerState<AuthenticationView> {
  final authProvider =
      StateNotifierProvider<AuthenticationProvider, AuthenticateState>((ref) {
    return AuthenticationProvider();
  });

  @override
  void initState() {
    super.initState();
    checkUser(FirebaseAuth.instance.currentUser);
  }

  void checkUser(User? user) {
    ref.read(authProvider.notifier).fetchUser(user);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            initialData: FirebaseAuth.instance.currentUser,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Padding(
                  padding: context.paddingMedium,
                  child: LoginView(
                    showTitle: false,
                    action: AuthAction.signUp,
                    providers: [
                      GoogleProvider(clientId: ''),
                    ],
                  ),
                );
              }
              return const NavigationView();
            },
          ),
        ),
      ),
    );
  }
}
