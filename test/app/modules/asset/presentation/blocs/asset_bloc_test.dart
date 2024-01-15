import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:variacao_ativo/app/core/shared/domain/failures/no_internet_connection_failure.dart';
import 'package:variacao_ativo/app/core/shared/presentation/controllers/states/abstractions/app_state.dart';
import 'package:variacao_ativo/app/core/shared/presentation/controllers/states/global_states/no_internet_connection_state.dart';
import 'package:variacao_ativo/app/modules/asset/domain/entities/asset_entity.dart';
import 'package:variacao_ativo/app/modules/asset/domain/entities/floor_entity.dart';
import 'package:variacao_ativo/app/modules/asset/domain/failures/asset_not_found_failure.dart';
import 'package:variacao_ativo/app/modules/asset/domain/failures/invalid_asset_code_failure.dart';
import 'package:variacao_ativo/app/modules/asset/domain/parameters/asset_search_parameters.dart';
import 'package:variacao_ativo/app/modules/asset/domain/usecases/get_asset_floor_data_by_code.dart';
import 'package:variacao_ativo/app/modules/asset/presentation/controllers/blocs/asset_bloc.dart';
import 'package:variacao_ativo/app/modules/asset/presentation/controllers/events/search_asset_floor_data_event.dart';
import 'package:variacao_ativo/app/modules/asset/presentation/controllers/states/asset_not_found_state.dart';
import 'package:variacao_ativo/app/modules/asset/presentation/controllers/states/getting_asset_floor_data_by_code_state.dart';
import 'package:variacao_ativo/app/modules/asset/presentation/controllers/states/invalid_asset_code_state.dart';
import 'package:variacao_ativo/app/modules/asset/presentation/controllers/states/successfully_got_asset_floor_data_by_code_state.dart';

class MockGetAssetFloorDataByCode extends Mock
    implements GetAssetFloorDataByCode {}

void main() {
  group(
    'AssetBloc',
    () {
      late AssetBloc assetBloc;
      late MockGetAssetFloorDataByCode mockGetAssetFloorDataByCode;

      setUp(() {
        registerFallbackValue(
          const SearchAssetFloorDataByCodeEvent(
            code: 'test',
          ),
        );
        registerFallbackValue(
          const AssetSearchParameters(
            code: 'test',
          ),
        );
        mockGetAssetFloorDataByCode = MockGetAssetFloorDataByCode();
        assetBloc = AssetBloc(mockGetAssetFloorDataByCode);
      });

      tearDown(() {
        assetBloc.close();
      });

      blocTest<AssetBloc, AppState>(
        'emits GettingAssetFloorDataByCodeState and SuccessfullyGotFloorDataByCodeState when GetAssetFloorDataByCode succeeds',
        build: () {
          when(() => mockGetAssetFloorDataByCode(any())).thenAnswer(
            (_) async => const Right(
              AssetEntity(
                code: 'PETR4.SA',
                floor: FloorEntity(dates: [], values: []),
              ),
            ),
          );
          return assetBloc;
        },
        act: (bloc) =>
            bloc.add(const SearchAssetFloorDataByCodeEvent(code: 'PETR4.SA')),
        expect: () => [
          isA<GettingAssetFloorDataByCodeState>(),
          isA<SuccessfullyGotFloorDataByCodeState>(),
        ],
      );

      blocTest<AssetBloc, AppState>(
        'emits GettingAssetFloorDataByCodeState and NoInternetConnectionState when GetAssetFloorDataByCode returns NoInternetConnectionFailure',
        build: () {
          when(() => mockGetAssetFloorDataByCode(any())).thenAnswer(
            (_) async => const Left(NoInternetConnectionFailure()),
          );
          return assetBloc;
        },
        act: (bloc) =>
            bloc.add(const SearchAssetFloorDataByCodeEvent(code: 'PETR4.SA')),
        expect: () => [
          isA<GettingAssetFloorDataByCodeState>(),
          isA<NoInternetConnectionState>(),
        ],
      );

      blocTest<AssetBloc, AppState>(
        'emits GettingAssetFloorDataByCodeState and AssetNotFoundState when GetAssetFloorDataByCode returns AssetNotFoundFailure',
        build: () {
          when(() => mockGetAssetFloorDataByCode(any()))
              .thenAnswer((_) async => const Left(AssetNotFoundFailure()));
          return assetBloc;
        },
        act: (bloc) =>
            bloc.add(const SearchAssetFloorDataByCodeEvent(code: 'PETR4.SA')),
        expect: () => [
          isA<GettingAssetFloorDataByCodeState>(),
          isA<AssetNotFoundState>(),
        ],
      );

      blocTest<AssetBloc, AppState>(
        'emits GettingAssetFloorDataByCodeState and InvalidAssetCodeState when GetAssetFloorDataByCode returns InvalidAssetCodeFailure',
        build: () {
          when(() => mockGetAssetFloorDataByCode(any()))
              .thenAnswer((_) async => const Left(InvalidAssetCodeFailure()));
          return assetBloc;
        },
        act: (bloc) =>
            bloc.add(const SearchAssetFloorDataByCodeEvent(code: 'INVALID')),
        expect: () => [
          isA<GettingAssetFloorDataByCodeState>(),
          isA<InvalidAssetCodeState>(),
        ],
      );
    },
  );
}
