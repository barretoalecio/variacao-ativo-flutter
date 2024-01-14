import 'package:equatable/equatable.dart';

class CoordinatorResultEntity extends Equatable {
  const CoordinatorResultEntity({
    required this.properRouteToNavigate,
  });

  final String properRouteToNavigate;

  @override
  List<Object?> get props => [
        properRouteToNavigate,
      ];
}
