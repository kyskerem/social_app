// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:social_app/products/utility/exceptions/version_exception.dart';

class VersionManager {
  final String appVersion;
  final String databaseAppVersion;
  VersionManager({
    required this.appVersion,
    required this.databaseAppVersion,
  });

  bool isNeedUpdate() {
    final parsedVersion = int.tryParse(appVersion.split('.').join());
    final parsedDatabaseVersion =
        int.tryParse(databaseAppVersion.split('.').join());
    if (parsedVersion == null || parsedDatabaseVersion == null) {
      throw VersionException(
        error: '$appVersion or $databaseAppVersion is not valid',
      );
    }
    return parsedVersion < parsedDatabaseVersion;
  }
}
