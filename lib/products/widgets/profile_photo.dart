import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:social_app/features/profile/profile_view.dart';
import 'package:social_app/products/enums/firebase_props_enum.dart';
import 'package:social_app/products/utility/firebase/firebase_collections.dart';

class ProfilePhoto extends StatelessWidget {
  ProfilePhoto({
    required String profilePhotoUrl,
    required String profileUid,
    super.key,
  }) {
    _profilePhotoUrl = profilePhotoUrl;
    _profileUid = profileUid;
  }

  late final String _profilePhotoUrl;
  late final String _profileUid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await FirebaseColletions.Users.reference
            .where(FirebaseProps.uid.name, isEqualTo: _profileUid)
            .get()
            .then(
              (value) => context
                  .navigateToPage(ProfileView(user: value.docs.first.data())),
            );
      },
      child: CircleAvatar(
        foregroundImage: NetworkImage(
          _profilePhotoUrl,
        ),
      ),
    );
  }
}
