import 'package:dartz/dartz.dart';

import '../../../../core/shared/domain/failures/failure.dart';
import '../../../../core/shared/domain/usecases/async_usecase.dart';
import '../entities/asset_entity.dart';
import '../failures/asset_failure.dart';
import '../failures/invalid_asset_code_failure.dart';
import '../parameters/asset_search_parameters.dart';
import '../repositories/asset_repository.dart';
import '../validators/asset_validator.dart';

abstract class GetAssetFloorDataByCode
    extends AsyncUsecase<AssetEntity, AssetSearchParameters> {
  const GetAssetFloorDataByCode();
}

class GetAssetFloorDataByCodeImplementation implements GetAssetFloorDataByCode {
  const GetAssetFloorDataByCodeImplementation(
    this._assetRepository,
    this._assetValidator,
  );

  final AssetRepository _assetRepository;
  final AssetValidator _assetValidator;

  @override
  Future<Either<Failure, AssetEntity>> call(
    AssetSearchParameters parameters,
  ) async {
    try {
      if (_assetValidator.hasValidCode(parameters.code)) {
        return await _assetRepository.getAssetFloorDataByCode(parameters);
      }
      return const Left(InvalidAssetCodeFailure());
    } catch (exception) {
      return Left(AssetFailure(exception.toString()));
    }
  }
}
