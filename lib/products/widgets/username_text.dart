import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

class UserNameText extends StatelessWidget {
  const UserNameText({
    required this.userName,
    super.key,
  });

  final String userName;

  @override
  Widget build(BuildContext context) {
    return Text(
      userName,
      textAlign: TextAlign.center,
      style: context.textTheme.bodyMedium!.copyWith(
        fontWeight: FontWeight.w300,
        color: Colors.white,
      ),
    );
  }
}
