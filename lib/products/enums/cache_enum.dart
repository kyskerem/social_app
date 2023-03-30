import 'package:social_app/products/initialize/local_cache.dart';

enum CacheKeys {
  token;

  String get read => LocalCache.instance.prefs.getString(name) ?? '';
  Future<bool> write(String value) =>
      LocalCache.instance.prefs.setString(name, value);
}
