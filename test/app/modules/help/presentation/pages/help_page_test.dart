import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:variacao_ativo/app/core/shared/presentation/widgets/app_bar/guide_app_bar.dart';
import 'package:variacao_ativo/app/modules/help/presentation/pages/help_page.dart';

void main() {
  group('HelpPage', () {
    testWidgets('should display GuideAppBar', (WidgetTester tester) async {
      await tester.pumpWidget(const MaterialApp(home: HelpPage()));

      expect(find.byType(GuideAppBar), findsOneWidget);
    });
  });
}
