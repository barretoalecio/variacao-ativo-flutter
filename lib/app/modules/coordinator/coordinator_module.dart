import 'package:flutter_modular/flutter_modular.dart';

import '../../core/utils/app_routes/coordinator_module_routes.dart';
import '../../core/utils/extensions/guide_route_manage_extension.dart';
import 'domain/repositories/coordinator_repository.dart';
import 'domain/usecases/get_proper_route_to_navigate.dart';
import 'infrastructure/repositories/coordinator_repository_implementation.dart';
import 'presentation/controllers/blocs/coordinator_bloc.dart';
import 'presentation/pages/coordinator_page.dart';

class CoordinatorModule extends Module {
  @override
  void exportedBinds(Injector i) {
    i.add<CoordinatorRepository>(CoordinatorRepositoryImplementation.new);
    i.add<GetProperRouteToNavigate>(GetProperRouteToNavigateImplementation.new);
    i.addSingleton(CoordinatorBloc.new);
  }

  @override
  void routes(RouteManager r) {
    r.guideChild(
      CoordinatorModuleRoutes.initialRoute,
      child: (context) => CoordinatorPage(),
    );
  }
}
