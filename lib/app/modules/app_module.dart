import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:http/http.dart' as http;

import '../core/packages/network/http_client/http_client.dart';
import '../core/packages/network/http_client/http_client_implementation.dart';
import '../core/packages/network/network_status/network_status.dart';
import '../core/utils/app_routes/asset_module_routes.dart';
import '../core/utils/app_routes/coordinator_module_routes.dart';
import '../core/utils/app_routes/help_module_routes.dart';
import '../core/utils/extensions/guide_route_manage_extension.dart';
import 'asset/asset_module.dart';
import 'coordinator/coordinator_module.dart';
import 'help/help_module.dart';

class AppModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.add(http.Client.new);
    i.add<HttpClient>(HttpClientImplementation.new);
    i.add(Connectivity.new);
    i.add<NetworkService>(NetworkServiceImplementation.new);
  }

  @override
  void routes(RouteManager r) {
    r.guideModule(
      CoordinatorModuleRoutes.moduleName,
      module: CoordinatorModule(),
    );

    r.guideModule(
      AssetModuleRoutes.moduleName,
      module: AssetModule(),
    );

    r.guideModule(
      HelpModuleRoutes.moduleName,
      module: HelpModule(),
    );
  }
}
