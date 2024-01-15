import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:variacao_ativo/app/core/packages/network/network_status/network_status.dart';
import 'package:variacao_ativo/app/core/shared/domain/failures/no_internet_connection_failure.dart';
import 'package:variacao_ativo/app/core/shared/domain/failures/server_failure.dart';
import 'package:variacao_ativo/app/modules/asset/domain/entities/asset_entity.dart';
import 'package:variacao_ativo/app/modules/asset/domain/entities/floor_entity.dart';
import 'package:variacao_ativo/app/modules/asset/domain/failures/asset_not_found_failure.dart';
import 'package:variacao_ativo/app/modules/asset/domain/failures/invalid_asset_code_failure.dart';
import 'package:variacao_ativo/app/modules/asset/domain/parameters/asset_search_parameters.dart';
import 'package:variacao_ativo/app/modules/asset/domain/repositories/asset_repository.dart';
import 'package:variacao_ativo/app/modules/asset/infrastructure/datasource/asset_datasource.dart';
import 'package:variacao_ativo/app/modules/asset/infrastructure/exceptions/asset_not_found_exception.dart';
import 'package:variacao_ativo/app/modules/asset/infrastructure/exceptions/invalid_asset_code_exception.dart';
import 'package:variacao_ativo/app/modules/asset/infrastructure/repositories/asset_repository_implementation.dart';

class MockAssetDataSource extends Mock implements AssetDataSource {}

class MockNetworkService extends Mock implements NetworkService {}

void main() {
  group('AssetRepositoryImplementation', () {
    late AssetRepository repository;
    late MockAssetDataSource mockAssetDataSource;
    late MockNetworkService mockNetworkService;

    setUp(() {
      mockAssetDataSource = MockAssetDataSource();
      mockNetworkService = MockNetworkService();
      repository = AssetRepositoryImplementation(
        mockAssetDataSource,
        mockNetworkService,
      );
    });

    test('should be an instance of AssetRepository', () {
      expect(repository, isA<AssetRepository>());
    });

    test('should return asset entity on successful call', () async {
      const parameters = AssetSearchParameters(code: 'PETR4.SA');
      const expectedAsset = AssetEntity(
        code: 'PETR4.SA',
        floor: FloorEntity(dates: [], values: []),
      );

      when(() => mockNetworkService.hasActiveNetwork)
          .thenAnswer((_) async => true);
      when(() => mockAssetDataSource.getAssetFloorDataByCode(parameters))
          .thenAnswer((_) async => expectedAsset);

      final result = await repository.getAssetFloorDataByCode(parameters);

      expect(result, equals(const Right(expectedAsset)));
      verify(() => mockNetworkService.hasActiveNetwork).called(1);
      verify(() => mockAssetDataSource.getAssetFloorDataByCode(parameters))
          .called(1);
      verifyNoMoreInteractions(mockNetworkService);
      verifyNoMoreInteractions(mockAssetDataSource);
    });

    test(
        'should return NoInternetConnectionFailure when there is no active network',
        () async {
      const parameters = AssetSearchParameters(code: 'PETR4.SA');

      when(() => mockNetworkService.hasActiveNetwork)
          .thenAnswer((_) async => false);

      final result = await repository.getAssetFloorDataByCode(parameters);

      expect(result, equals(const Left(NoInternetConnectionFailure())));
      verify(() => mockNetworkService.hasActiveNetwork).called(1);
      verifyNoMoreInteractions(mockNetworkService);
      verifyNoMoreInteractions(mockAssetDataSource);
    });

    test('should return InvalidAssetCodeFailure on InvalidAssetCodeException',
        () async {
      const parameters = AssetSearchParameters(code: 'INVALID');

      when(() => mockNetworkService.hasActiveNetwork)
          .thenAnswer((_) async => true);
      when(() => mockAssetDataSource.getAssetFloorDataByCode(parameters))
          .thenThrow(const InvalidAssetCodeException());

      final result = await repository.getAssetFloorDataByCode(parameters);

      expect(result, equals(const Left(InvalidAssetCodeFailure())));
      verify(() => mockNetworkService.hasActiveNetwork).called(1);
      verify(() => mockAssetDataSource.getAssetFloorDataByCode(parameters))
          .called(1);
      verifyNoMoreInteractions(mockNetworkService);
      verifyNoMoreInteractions(mockAssetDataSource);
    });

    test('should return AssetNotFoundFailure on AssetNotFoundException',
        () async {
      const parameters = AssetSearchParameters(code: 'PETR4.SA');

      when(() => mockNetworkService.hasActiveNetwork)
          .thenAnswer((_) async => true);
      when(() => mockAssetDataSource.getAssetFloorDataByCode(parameters))
          .thenThrow(const AssetNotFoundException());

      final result = await repository.getAssetFloorDataByCode(parameters);

      expect(result, equals(const Left(AssetNotFoundFailure())));
      verify(() => mockNetworkService.hasActiveNetwork).called(1);
      verify(() => mockAssetDataSource.getAssetFloorDataByCode(parameters))
          .called(1);
      verifyNoMoreInteractions(mockNetworkService);
      verifyNoMoreInteractions(mockAssetDataSource);
    });

    test('should return ServerFailure on generic exception', () async {
      const parameters = AssetSearchParameters(code: 'PETR4.SA');

      when(() => mockNetworkService.hasActiveNetwork)
          .thenAnswer((_) async => true);
      when(() => mockAssetDataSource.getAssetFloorDataByCode(parameters))
          .thenThrow(Exception('Test Error'));

      final result = await repository.getAssetFloorDataByCode(parameters);

      expect(result, equals(const Left(ServerFailure())));
      verify(() => mockNetworkService.hasActiveNetwork).called(1);
      verify(() => mockAssetDataSource.getAssetFloorDataByCode(parameters))
          .called(1);
      verifyNoMoreInteractions(mockNetworkService);
      verifyNoMoreInteractions(mockAssetDataSource);
    });
  });
}
