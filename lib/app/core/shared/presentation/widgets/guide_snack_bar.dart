import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unicons/unicons.dart';

import '../controllers/states/abstractions/app_state.dart';
import '../controllers/states/abstractions/error_state.dart';
import '../controllers/states/abstractions/processing_state.dart';

class GuideSnackBar {
  const GuideSnackBar();

  static void showSnackBar(
    BuildContext context,
    AppState state, {
    Color? backgroundColor,
    IconData? icon,
  }) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();

    if (state is ProcessingState) {
      backgroundColor = const Color(0xFFEBC957);
      icon = null;
    } else if (state is ErrorState) {
      backgroundColor = const Color(0xFFEB5757);
      icon = UniconsLine.exclamation_triangle;
    } else {
      backgroundColor = const Color(0xFF2EC28B);
      icon = UniconsLine.check_circle;
    }

    final snackBar = SnackBar(
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      duration: const Duration(seconds: 5),
      elevation: 0,
      content: Row(
        children: [
          if (icon == null)
            const CupertinoActivityIndicator()
          else
            Icon(
              icon,
              color: Theme.of(context).colorScheme.background,
            ),
          const SizedBox(width: 16),
          Flexible(
            child: Text(
              state.message,
              style: Theme.of(context)
                  .textTheme
                  .titleMedium!
                  .copyWith(color: Theme.of(context).colorScheme.background),
            ),
          ),
        ],
      ),
      backgroundColor: backgroundColor,
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  static void hideSnackbar(
    BuildContext context,
  ) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
  }
}
