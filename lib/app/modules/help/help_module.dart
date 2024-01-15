import 'package:flutter_modular/flutter_modular.dart';

import '../../core/utils/app_routes/help_module_routes.dart';
import '../../core/utils/extensions/guide_route_manage_extension.dart';
import 'presentation/pages/help_page.dart';

class HelpModule extends Module {
  @override
  void routes(RouteManager r) {
    r.guideChild(
      HelpModuleRoutes.initialRoute,
      child: (context) => const HelpPage(),
    );
  }
}
