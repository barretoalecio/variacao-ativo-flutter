import 'package:equatable/equatable.dart';

class HttpResponse extends Equatable {
  const HttpResponse({this.data, this.statusCode});

  final String? data;
  final int? statusCode;

  @override
  List<Object?> get props => [data, statusCode];
}
