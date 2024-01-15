import '../../../../../core/shared/presentation/controllers/states/abstractions/success_state.dart';
import '../../../domain/entities/asset_entity.dart';
import '../../../utils/messages/states/asset_state_messages.dart';

class SuccessfullyGotFloorDataByCodeState implements SuccessState {
  const SuccessfullyGotFloorDataByCodeState(this.assetEntity);

  final AssetEntity assetEntity;

  @override
  String get message => AssetStateMessages.successfullyGotAssetFloorData;
}
