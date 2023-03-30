import 'package:flutter/foundation.dart';

@immutable
class FbCustomException implements Exception {
  const FbCustomException({required this.error});
  final String error;

  @override
  String toString() {
    return '$this $error';
  }
}
