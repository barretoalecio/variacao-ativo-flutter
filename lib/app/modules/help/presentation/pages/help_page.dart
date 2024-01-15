import 'package:flutter/material.dart';

import '../../../../core/shared/presentation/widgets/app_bar/guide_app_bar.dart';
import '../../../../core/utils/mixins/no_internet_mixin.dart';
import '../../utils/help_page_string_utils.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> with NoInternetMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: const GuideAppBar(),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          primary: true,
          padding: const EdgeInsets.all(16.0),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SelectableText(
                HelpPageStringUtils.FIRST_QUESTION,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SelectableText(
              HelpPageStringUtils.FIRST_ANSWER,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SelectableText(
                HelpPageStringUtils.SECOND_QUESTION,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SelectableText(
              HelpPageStringUtils.SECOND_ANSWER,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: SelectableText(
                HelpPageStringUtils.THIRD_QUESTION,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
            const SelectableText(
              HelpPageStringUtils.THIRD_ANSWER,
            ),
          ],
        ),
      ),
    );
  }
}
