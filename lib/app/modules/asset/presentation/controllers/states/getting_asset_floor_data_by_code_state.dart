import '../../../../../core/shared/presentation/controllers/states/abstractions/processing_state.dart';
import '../../../utils/messages/states/asset_state_messages.dart';

class GettingAssetFloorDataByCodeState implements ProcessingState {
  @override
  String get message => AssetStateMessages.gettingAssetFloorDataByCode;
}
