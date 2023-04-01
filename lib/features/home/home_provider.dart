import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/products/enums/firebase_props_enum.dart';
import 'package:social_app/products/models/post_model.dart';

import 'package:social_app/products/utility/firebase/firebase_collections.dart';

class HomeProvider extends StateNotifier<HomeState> {
  HomeProvider() : super(HomeState());

  Stream<QuerySnapshot<Post>> fetchPosts() {
    final snapshot = FirebaseColletions.Posts.reference
        .withConverter<Post>(
          fromFirestore: (snapshot, options) {
            return Post.fromJson(snapshot.data() ?? {});
          },
          toFirestore: (value, options) {
            return value.toMap(value);
          },
        )
        .orderBy(
          FirebaseProps.datePublished.value,
          descending: true,
        )
        .snapshots();

    return snapshot;
  }
}

@immutable
class HomeState extends Equatable {
  @override
  List<Object?> get props => throw UnimplementedError();
}
