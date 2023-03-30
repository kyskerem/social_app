// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars

import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:social_app/products/enums/cache_enum.dart';
import 'package:social_app/products/extension/user_extension.dart';
import 'package:social_app/products/utility/firebase/firebase_collections.dart';

class AuthenticationProvider extends StateNotifier<AuthenticateState> {
  AuthenticationProvider() : super(const AuthenticateState());

  Future<void> fetchUser(User? user) async {
    if (user == null) return;

    await saveUserToDatabase(user);
    final token = await user.getIdToken();
    await _saveTokenToCache(token);
    state = state.copyWith(redirect: true);
  }

  Future<void> saveUserToDatabase(User user) async {
    await FirebaseColletions.Users.reference.doc(user.uid).set(
          user.toMap(),
        );
  }

  Future<void> _saveTokenToCache(String token) async {
    await CacheKeys.token.write(token);
  }
}

@immutable
class AuthenticateState extends Equatable {
  final bool redirect;
  const AuthenticateState({
    this.redirect = false,
  });

  @override
  List<Object?> get props => [redirect];

  AuthenticateState copyWith({
    bool? redirect,
  }) {
    return AuthenticateState(
      redirect: redirect ?? this.redirect,
    );
  }
}
