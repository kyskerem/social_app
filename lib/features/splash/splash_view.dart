import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kartal/kartal.dart';
import 'package:social_app/features/splash/splash_providers.dart';
import 'package:social_app/products/constants/string_constants.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with _SplashViewListenMixin {
  final splashProvider = StateNotifierProvider<SplashProvider, SplashState>(
    (ref) => SplashProvider(),
  );
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.read(splashProvider.notifier).checkAppVersion(''.version);
    listenAndNavigate(splashProvider);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          DefaultTextStyle(
            style: const TextStyle(
              fontSize: 35,
              fontWeight: FontWeight.w300,
            ),
            child: AnimatedTextKit(
              repeatForever: true,
              animatedTexts: [
                WavyAnimatedText(StringConstants.hello),
              ],
              onTap: () {},
            ),
          )
        ],
      ),
    );
  }
}

mixin _SplashViewListenMixin on ConsumerState<SplashView> {
  void listenAndNavigate(
    StateNotifierProvider<SplashProvider, SplashState> provider,
  ) {
    ref.listen(provider, (previous, next) {
      if ((next.forceUpdate ?? false) == true) {
        return showAboutDialog(context: context);
      }
      if (next.redirectHome != null) {
        if (next.redirectHome!) {
          context.navigateName('Home');
        } else {
          context.navigateName('Home');
        }
      }
    });
  }
}
