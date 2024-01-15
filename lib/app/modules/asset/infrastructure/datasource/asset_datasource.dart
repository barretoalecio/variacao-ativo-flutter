import '../../domain/entities/asset_entity.dart';
import '../../domain/parameters/asset_search_parameters.dart';

abstract class AssetDataSource {
  Future<AssetEntity> getAssetFloorDataByCode(AssetSearchParameters parameters);
}
