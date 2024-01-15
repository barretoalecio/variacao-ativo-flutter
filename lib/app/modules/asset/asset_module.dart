import 'package:flutter_modular/flutter_modular.dart';

import '../../core/utils/app_routes/asset_module_routes.dart';
import '../../core/utils/extensions/guide_route_manage_extension.dart';
import '../app_module.dart';
import 'domain/repositories/asset_repository.dart';
import 'domain/usecases/get_asset_floor_data_by_code.dart';
import 'domain/validators/asset_validator.dart';
import 'external/datasources/asset_datasource_implementation.dart';
import 'infrastructure/datasource/asset_datasource.dart';
import 'infrastructure/repositories/asset_repository_implementation.dart';
import 'presentation/controllers/blocs/asset_bloc.dart';
import 'presentation/pages/asset_floor_details_page.dart';
import 'presentation/pages/search_asset_page.dart';

class AssetModule extends Module {
  @override
  List<Module> get imports => [
        AppModule(),
      ];

  @override
  void binds(Injector i) {
    i.add<AssetDataSource>(AssetDataSourceImplementation.new);
    i.add<AssetRepository>(AssetRepositoryImplementation.new);
    i.add<AssetValidator>(AssetValidatorImplementation.new);
    i.add<GetAssetFloorDataByCode>(GetAssetFloorDataByCodeImplementation.new);
    i.add(AssetBloc.new);
  }

  @override
  void routes(RouteManager r) {
    r.guideChild(
      AssetModuleRoutes.initialRoute,
      child: (context) => const SearchAssetPage(),
    );

    r.guideChild(
      '${AssetModuleRoutes.detailsRoute}/:code',
      child: (context) => AssetFloorDetailsPage(
        assetBloc: Modular.get<AssetBloc>(),
        assetCode: r.args.params['code'],
      ),
    );
  }
}
