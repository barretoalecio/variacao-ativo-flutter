import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:unicons/unicons.dart';

import '../main_logo.dart';

class GuideBanner extends StatelessWidget {
  const GuideBanner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () => Modular.to.maybePop(),
          icon: const Icon(UniconsLine.angle_left),
          splashRadius: 24,
          iconSize: 24,
          tooltip: 'Retornar',
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4.5,
        ),
        const MainLogo(
          width: 128,
        ),
      ],
    );
  }
}
