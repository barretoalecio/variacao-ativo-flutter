import 'package:flutter/material.dart';

import '../../../utils/assets/png_assets.dart';
import '../../../utils/mixins/no_internet_mixin.dart';
import '../widgets/disable_splash.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({required this.onAnimationCompleted});
  final void Function() onAnimationCompleted;

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with NoInternetMixin {
  double opacity = 0.0;
  double scale = 0.0;

  @override
  void initState() {
    super.initState();

    Future.delayed(
      const Duration(seconds: 1),
      () => setState(() {
        opacity = 1;
        scale = 1;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: DisableSplash(
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.5,
                    width: MediaQuery.of(context).size.width * 0.5,
                    child: AnimatedScale(
                      scale: scale,
                      duration: const Duration(milliseconds: 500),
                      child: Image.asset(
                        PngAssets.logo,
                        height: 128,
                      ),
                    ),
                  ),
                ),
                AnimatedOpacity(
                  opacity: opacity,
                  onEnd: () async => await Future.delayed(
                    const Duration(seconds: 1),
                    widget.onAnimationCompleted,
                  ),
                  duration: const Duration(seconds: 1),
                  curve: Curves.easeInOutQuart,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: RichText(
                      text: TextSpan(
                        text: 'Desenvolvido por ',
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.w400,
                            ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'Alécio Barreto',
                            style: Theme.of(context).textTheme.titleSmall!.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
