import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../../../core/shared/domain/failures/no_internet_connection_failure.dart';
import '../../../../../core/shared/presentation/controllers/states/abstractions/app_state.dart';
import '../../../../../core/shared/presentation/controllers/states/global_states/idle_state.dart';
import '../../../../../core/shared/presentation/controllers/states/global_states/no_internet_connection_state.dart';
import '../../../domain/failures/asset_not_found_failure.dart';
import '../../../domain/failures/invalid_asset_code_failure.dart';
import '../../../domain/parameters/asset_search_parameters.dart';
import '../../../domain/usecases/get_asset_floor_data_by_code.dart';
import '../events/asset_event.dart';
import '../events/search_asset_floor_data_event.dart';
import '../states/asset_not_found_state.dart';
import '../states/getting_asset_floor_data_by_code_state.dart';
import '../states/invalid_asset_code_state.dart';
import '../states/successfully_got_asset_floor_data_by_code_state.dart';
import '../states/unable_to_get_asset_floor_data_by_code_state.dart';

class AssetBloc extends Bloc<AssetEvent, AppState> implements Disposable {
  AssetBloc(this._getAssetFloorDataByCode) : super(IdleState()) {
    on<SearchAssetFloorDataByCodeEvent>(_onSearchAssetFloorDataByCodeEvent);
  }

  final GetAssetFloorDataByCode _getAssetFloorDataByCode;

  FutureOr<void> _onSearchAssetFloorDataByCodeEvent(
    SearchAssetFloorDataByCodeEvent event,
    Emitter<AppState> emit,
  ) async {
    emit(GettingAssetFloorDataByCodeState());

    final result = await _getAssetFloorDataByCode(
      AssetSearchParameters(
        code: event.code,
      ),
    );

    emit(
      result.fold(
        (failure) {
          switch (failure.runtimeType) {
            case NoInternetConnectionFailure:
              return NoInternetConnectionState();
            case AssetNotFoundFailure:
              return AssetNotFoundState();
            case InvalidAssetCodeFailure:
              return InvalidAssetCodeState();
            default:
              return UnableToGetAssetFloorDataByCodeState();
          }
        },
        (success) => SuccessfullyGotFloorDataByCodeState(success),
      ),
    );
  }

  @override
  void dispose() => close();
}
