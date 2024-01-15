import '../../../../../core/shared/presentation/controllers/states/abstractions/error_state.dart';
import '../../../utils/messages/states/asset_state_messages.dart';

class AssetNotFoundState implements ErrorState {
  @override
  String get message => AssetStateMessages.assetNotFound;
}
