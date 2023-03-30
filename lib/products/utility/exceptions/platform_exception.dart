import 'package:flutter/material.dart';

@immutable
class PlatformException implements Exception {
  const PlatformException({required this.error});
  final String error;

  @override
  String toString() {
    return '$this $error';
  }
}
