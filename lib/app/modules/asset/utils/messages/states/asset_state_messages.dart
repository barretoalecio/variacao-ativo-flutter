import '../errors/asset_error_messages.dart';

class AssetStateMessages {
  const AssetStateMessages();

  static const successfullyGotAssetFloorData = 'Dados obtidos com sucesso';
  static const gettingAssetFloorDataByCode = 'Obtendo dados...';
  static const unableToGetAssetFloorDataByCode =
      AssetErrorMessages.unableToGetAssetFloorDataByCode;
  static const assetNotFound = AssetErrorMessages.assetNotFound;
  static const invalidAssetCode = AssetErrorMessages.invalidAssetCode;
}
