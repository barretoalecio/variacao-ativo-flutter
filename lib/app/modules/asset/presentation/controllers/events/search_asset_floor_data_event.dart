import 'asset_event.dart';

class SearchAssetFloorDataByCodeEvent implements AssetEvent {
  const SearchAssetFloorDataByCodeEvent({required this.code});

  final String code;
}
