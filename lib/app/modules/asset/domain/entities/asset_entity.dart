import 'package:equatable/equatable.dart';

import 'floor_entity.dart';

class AssetEntity extends Equatable {
  const AssetEntity({
    required this.code,
    required this.floor,
  });

  final String code;
  final FloorEntity floor;

  @override
  List<Object?> get props => [
        code,
        floor,
      ];
}
