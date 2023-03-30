import 'package:shared_preferences/shared_preferences.dart';

class LocalCache {
  LocalCache._();
  static LocalCache instance = LocalCache._();
  late final SharedPreferences prefs;

  Future<void> init() async {
    prefs = await SharedPreferences.getInstance();
  }
}
