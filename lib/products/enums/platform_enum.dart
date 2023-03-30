import 'dart:io';

import 'package:social_app/products/constants/string_constants.dart';
import 'package:social_app/products/utility/exceptions/platform_exception.dart';

enum PlatformEnum {
  android,
  ios;

  static String get platformName {
    if (Platform.isAndroid) {
      return PlatformEnum.android.name;
    } else if (Platform.isIOS) {
      return PlatformEnum.ios.name;
    }
    throw const PlatformException(
      error: StringConstants.onlyAndroindAndIos,
    );
  }
}
