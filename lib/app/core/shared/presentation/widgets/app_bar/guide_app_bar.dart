import 'package:flutter/material.dart';

import 'guide_banner.dart';

class GuideAppBar extends StatelessWidget implements PreferredSizeWidget {
  const GuideAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Material(
          elevation: 1.0,
          color: Colors.white,
          child: GuideBanner(),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size(500, 100);
}
