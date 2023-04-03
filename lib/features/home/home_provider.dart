import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:social_app/core/models/post_model.dart';
import 'package:social_app/products/enums/firebase_props_enum.dart';
import 'package:social_app/products/utility/firebase/firebase_collections.dart';

class HomeProvider {
  HomeProvider();

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
