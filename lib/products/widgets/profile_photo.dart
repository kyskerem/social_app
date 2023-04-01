import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';
import 'package:social_app/features/profile/profile_view.dart';
import 'package:social_app/products/enums/firebase_props_enum.dart';
import 'package:social_app/products/utility/firebase/firebase_collections.dart';

class ProfilePhoto extends StatelessWidget {
  ProfilePhoto({
    required String profilePhotoUrl,
    required String profileUid,
    required bool redirect,
    super.key,
  }) {
    _profilePhotoUrl = profilePhotoUrl;
    _profileUid = profileUid;
    _redirect = redirect;
  }

  late final String _profilePhotoUrl;
  late final String _profileUid;
  late final bool _redirect;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _redirect
          ? () async {
              await FirebaseColletions.Users.reference
                  .where(FirebaseProps.uid.name, isEqualTo: _profileUid)
                  .get()
                  .then(
                    (value) => context.navigateToPage(
                      ProfileView(user: value.docs.first.data()),
                    ),
                  );
            }
          : () => showDialog<Dialog>(
                context: context,
                builder: (context) {
                  return Dialog(
                    child: InteractiveViewer(
                      child: Image.network(_profilePhotoUrl),
                    ),
                  );
                },
              ),
      child: CircleAvatar(
        foregroundImage: NetworkImage(
          _profilePhotoUrl,
        ),
      ),
    );
  }
}
