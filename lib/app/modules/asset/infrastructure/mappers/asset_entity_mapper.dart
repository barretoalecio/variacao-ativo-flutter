import 'dart:convert';

import '../../domain/entities/asset_entity.dart';
import 'floor_entity_mapper.dart';

class AssetEntityMapper {
  static AssetEntity fromMap(Map<String, dynamic> map) {
    Map<String, dynamic> resultMap = map['chart']['result'].first;

    return AssetEntity(
      code: resultMap['meta']['symbol'],
      floor: FloorEntityMapper.fromMap(resultMap),
    );
  }

  static AssetEntity fromJSON(String source) => fromMap(json.decode(source));
}
