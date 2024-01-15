import 'package:flutter/material.dart';

import '../../../utils/assets/png_assets.dart';
import '../../../utils/tags/hero_tags.dart';

class MainLogo extends StatelessWidget {
  const MainLogo({
    super.key,
    this.height = 128,
    this.width = 128,
  });

  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: HeroTags.MAIN_LOGO,
      child: Image.asset(
        PngAssets.logo,
        height: height,
        width: width,
      ),
    );
  }
}
