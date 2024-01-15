import '../../../../core/shared/infrastructure/exceptions/core_exception.dart';

class AssetException implements CoreException {
  const AssetException([this.message]);

  @override
  final String? message;
}
