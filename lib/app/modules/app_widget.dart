import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';

import '../core/utils/listeners/status_bar_color_listener.dart';
import '../core/utils/themes/guide_theme.dart';

class AppWidget extends StatefulWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  _AppWidgetState createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  void initState() {
    super.initState();

    Intl.defaultLocale = 'pt_BR';

    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    Modular.to.addListener(
      () => StatusBarColorListener.defineProperStatusBarColorToRoute(
        route: Modular.to.path,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR')],
      theme: guideTheme,
      title: 'Variacao de Ativo Mobile',
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
