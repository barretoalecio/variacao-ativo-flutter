import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../entities/asset_entity.dart';
import '../parameters/asset_search_parameters.dart';

abstract class AssetRepository {
  Future<Either<Failure, AssetEntity>> getAssetFloorDataByCode(
    AssetSearchParameters parameters,
  );
}
