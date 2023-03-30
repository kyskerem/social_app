import 'package:flutter/foundation.dart';

@immutable
class VersionException implements Exception {
  const VersionException({required this.error});
  final String error;

  @override
  String toString() {
    return '$this $error';
  }
}
