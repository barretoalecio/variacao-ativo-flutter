import 'package:equatable/equatable.dart';

class AssetSearchParameters extends Equatable {
  const AssetSearchParameters({
    required this.code,
  });

  final String code;

  @override
  List<Object?> get props => [
        code,
      ];
}
