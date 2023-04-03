import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kartal/kartal.dart';

import 'package:social_app/firebase_options.dart';
import 'package:social_app/products/initialize/local_cache.dart';

@immutable
class ApplicationInit {
  const ApplicationInit._();

  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await DeviceUtility.deviceInit();
    await LocalCache.instance.init();
    await dotenv.load();

    FirebaseUIAuth.configureProviders(
      [GoogleProvider(clientId: '')],
    );
  }
}
