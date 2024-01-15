import 'package:equatable/equatable.dart';

class FloorEntity extends Equatable {
  const FloorEntity({
    required this.dates,
    required this.values,
  });

  final List<DateTime> dates;
  final List<double> values;

  @override
  List<Object?> get props => [
        dates,
        values,
      ];
}
