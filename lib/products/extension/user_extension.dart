// ignore_for_file: lines_longer_than_80_chars

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:social_app/products/enums/firebase_props_enum.dart';

extension MapExtension on User {
  Map<String, dynamic> toMap() {
    final defaultPpUrl =
        '${dotenv.env['STORAGE_DEFAULT_BASE_URL']}defaultpp.png${dotenv.env['STORAGE_URL_LAST']}';

    final map = <String, dynamic>{
      FirebaseProps.displayName.value: displayName,
      FirebaseProps.creationTime.value: metadata.creationTime,
      FirebaseProps.lastSignInTime.value: metadata.lastSignInTime,
      FirebaseProps.email.value: email,
      FirebaseProps.photoURL.value: photoURL ?? defaultPpUrl,
      FirebaseProps.uid.value: uid,
    };
    return map;
  }
}
