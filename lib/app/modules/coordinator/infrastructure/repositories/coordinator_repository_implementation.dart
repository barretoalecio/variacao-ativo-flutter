import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../../../../core/utils/app_routes/asset_module_routes.dart';
import '../../domain/entities/coordinator_result_entity.dart';
import '../../domain/repositories/coordinator_repository.dart';

class CoordinatorRepositoryImplementation implements CoordinatorRepository {
  const CoordinatorRepositoryImplementation();

  @override
  Future<Either<Failure, CoordinatorResultEntity>>
      getProperRouteToNavigate() async {
    return const Right(
      CoordinatorResultEntity(
        properRouteToNavigate:
            '${AssetModuleRoutes.moduleName}${AssetModuleRoutes.initialRoute}',
      ),
    );
  }
}
