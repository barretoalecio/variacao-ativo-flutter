import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'app/core/utils/configuration/app_configuration.dart';
import 'app/core/utils/configuration/flavors.dart';
import 'app/modules/app_module.dart';
import 'app/modules/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  runApp(
    AppConfiguration(
      flavorOption: FlavorOption.development,
      child: ModularApp(
        module: AppModule(),
        child: const AppWidget(),
      ),
    ),
  );
}
