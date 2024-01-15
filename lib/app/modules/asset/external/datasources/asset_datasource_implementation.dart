import 'dart:convert';

import '../../../../core/packages/network/http_client/http_client.dart';
import '../../../../core/shared/infrastructure/exceptions/server_exception.dart';
import '../../../../core/utils/api_routes/api_routes.dart';
import '../../domain/entities/asset_entity.dart';
import '../../domain/parameters/asset_search_parameters.dart';
import '../../infrastructure/datasource/asset_datasource.dart';
import '../../infrastructure/exceptions/asset_not_found_exception.dart';
import '../../infrastructure/mappers/asset_entity_mapper.dart';

class AssetDataSourceImplementation implements AssetDataSource {
  const AssetDataSourceImplementation(this._httpClient);

  final HttpClient _httpClient;

  @override
  Future<AssetEntity> getAssetFloorDataByCode(
    AssetSearchParameters parameters,
  ) async {
    final endpoint = APIRoutes.getLast30AssetFlorDataByName(
      parameters.code,
    );
    final result = await _httpClient.get(endpoint);
    switch (result.statusCode) {
      case 200:
        {
          final decodedResponse = jsonDecode(result.data!);
          final assetData =
              AssetEntityMapper.fromJSON(jsonEncode(decodedResponse));
          return assetData;
        }
      case 404:
        throw const AssetNotFoundException();
      default:
        throw ServerException(
          message:
              result.data != null ? jsonDecode(result.data!)['message'] : '',
          statusCode: result.statusCode!,
        );
    }
  }
}
