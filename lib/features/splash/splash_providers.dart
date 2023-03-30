// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:equatable/equatable.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:social_app/products/constants/index.dart';

import 'package:social_app/products/enums/platform_enum.dart';
import 'package:social_app/products/models/number_model.dart';
import 'package:social_app/products/utility/exceptions/firebase_exception.dart';
import 'package:social_app/products/utility/firebase/firebase_collections.dart';
import 'package:social_app/products/utility/version_manager.dart';

class SplashProvider extends StateNotifier<SplashState> {
  SplashProvider() : super(const SplashState());

  Future<void> checkAppVersion(String clientVersion) async {
    final dbVersion = await getVersion();
    if (dbVersion.isEmpty) {
      state = state.copyWith(redirectHome: false);
      return;
    }
    final checkUpdate = VersionManager(
      appVersion: clientVersion,
      databaseAppVersion: dbVersion,
    );
    if (checkUpdate.isNeedUpdate()) {
      state = state.copyWith(forceUpdate: true);
      return;
    } else {
      state = state.copyWith(redirectHome: true);
    }
  }

  Future<String> getVersion() async {
    late final Version? version;
    await FirebaseColletions.Version.reference
        .withConverter(
          fromFirestore: (snapshot, options) {
            return Version.fromMap(snapshot.data() ?? {});
          },
          toFirestore: (value, options) => value.toJson(value),
        )
        .doc(PlatformEnum.platformName)
        .get()
        .then((value) => version = value.data());

    if (version?.number == null) {
      throw const FbCustomException(error: StringConstants.versionNotFound);
    }

    return version!.number;
  }
}

class SplashState extends Equatable {
  final bool? forceUpdate;
  final bool? redirectHome;
  const SplashState({
    this.forceUpdate,
    this.redirectHome,
  });

  @override
  List<Object?> get props => [forceUpdate, redirectHome];

  SplashState copyWith({
    bool? forceUpdate,
    bool? redirectHome,
  }) {
    return SplashState(
      forceUpdate: forceUpdate ?? this.forceUpdate,
      redirectHome: redirectHome ?? this.redirectHome,
    );
  }
}
