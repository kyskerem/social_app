import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

extension MapExtension on User {
  Map<String, dynamic> toMap() {
    final defaultPpUrl =
        '${dotenv.env['STORAGE_DEFAULT_BASE_URL']}defaultpp.png${dotenv.env['STORAGE_URL_LAST']}';

    final map = <String, dynamic>{
      'displayName': displayName,
      'creationTime': metadata.creationTime,
      'lastSignInTime': metadata.lastSignInTime,
      'email': email,
      'photoURL': photoURL ?? defaultPpUrl,
      'uid': uid,
    };
    return map;
  }
}
