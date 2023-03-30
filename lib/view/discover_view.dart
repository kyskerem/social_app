// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';

// import 'package:social_app/products/models/post_model.dart';
// import 'package:social_app/products/widgets/image_card.dart';

// class DiscoverView extends StatelessWidget {
//   const DiscoverView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     CollectionReference ref = FirebaseFirestore.instance.collection('Posts');

//     final posts = ref.withConverter<Post>(
//       fromFirestore: (snapshot, options) {
//         //TODO:
//         return Post().fromFirebase(snapshot, Post.fromJson);
//       },
//       toFirestore: (value, options) {
//         return Post().toJson(value);
//       },
//     ).get();

//     return Scaffold(
//       body: FutureBuilder(
//         future: posts,
//         builder: (context, snapshot) {
//           switch (snapshot.connectionState) {
//             case ConnectionState.none:
//             case ConnectionState.waiting:
//             case ConnectionState.active:
//               return const CircularProgressIndicator();
//             case ConnectionState.done:
//               if (snapshot.hasData) {
//                 final data = snapshot.data!.docs.map((e) => e.data()).toList();
//                 return ListView.builder(
//                   itemCount: snapshot.data?.size ?? 0,
//                   itemBuilder: (context, index) {
//                     return ImageCard(
//                       post: data[index],
//                     );
//                   },
//                 );
//               } else {
//                 return const Text('noData');
//               }
//           }
//         },
//       ),
//     );
//   }
// }
