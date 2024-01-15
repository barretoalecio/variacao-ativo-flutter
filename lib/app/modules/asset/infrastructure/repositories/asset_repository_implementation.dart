import 'package:dartz/dartz.dart';

import '../../../../core/packages/network/network_status/network_status.dart';
import '../../../../core/shared/domain/failures/failure.dart';
import '../../../../core/shared/domain/failures/no_internet_connection_failure.dart';
import '../../../../core/shared/domain/failures/server_failure.dart';
import '../../domain/entities/asset_entity.dart';
import '../../domain/failures/asset_not_found_failure.dart';
import '../../domain/failures/invalid_asset_code_failure.dart';
import '../../domain/parameters/asset_search_parameters.dart';
import '../../domain/repositories/asset_repository.dart';
import '../datasource/asset_datasource.dart';
import '../exceptions/asset_not_found_exception.dart';
import '../exceptions/invalid_asset_code_exception.dart';

class AssetRepositoryImplementation implements AssetRepository {
  const AssetRepositoryImplementation(
    this._dataSource,
    this._networkService,
  );

  final AssetDataSource _dataSource;
  final NetworkService _networkService;

  @override
  Future<Either<Failure, AssetEntity>> getAssetFloorDataByCode(
    AssetSearchParameters parameters,
  ) async {
    try {
      if (await _networkService.hasActiveNetwork) {
        final result = await _dataSource.getAssetFloorDataByCode(parameters);
        return Right(result);
      }
      return const Left(NoInternetConnectionFailure());
    } on InvalidAssetCodeException {
      return const Left(InvalidAssetCodeFailure());
    } on AssetNotFoundException {
      return const Left(AssetNotFoundFailure());
    } catch (exception) {
      return const Left(ServerFailure());
    }
  }
}
