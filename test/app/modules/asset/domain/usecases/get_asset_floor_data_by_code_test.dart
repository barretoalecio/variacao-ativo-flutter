import 'package:dartz/dartz.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:variacao_ativo/app/modules/asset/domain/entities/asset_entity.dart';
import 'package:variacao_ativo/app/modules/asset/domain/entities/floor_entity.dart';
import 'package:variacao_ativo/app/modules/asset/domain/failures/invalid_asset_code_failure.dart';
import 'package:variacao_ativo/app/modules/asset/domain/parameters/asset_search_parameters.dart';
import 'package:variacao_ativo/app/modules/asset/domain/repositories/asset_repository.dart';
import 'package:variacao_ativo/app/modules/asset/domain/usecases/get_asset_floor_data_by_code.dart';
import 'package:variacao_ativo/app/modules/asset/domain/validators/asset_validator.dart';

class MockAssetValidator extends Mock implements AssetValidator {}

class MockAssetRepository extends Mock implements AssetRepository {}

void main() {
  group('GetAssetFloorDataByCodeImplementation', () {
    late GetAssetFloorDataByCode usecase;
    late MockAssetRepository mockAssetRepository;
    late MockAssetValidator mockAssetValidator;

    setUp(() {
      mockAssetRepository = MockAssetRepository();
      mockAssetValidator = MockAssetValidator();
      usecase = GetAssetFloorDataByCodeImplementation(
        mockAssetRepository,
        mockAssetValidator,
      );
    });

    test('should return asset entity on successful call', () async {
      const parameters = AssetSearchParameters(code: 'PETR4.SA');
      const expectedAsset = AssetEntity(
        code: 'PETR4.SA',
        floor: FloorEntity(dates: [], values: []),
      );

      when(() => mockAssetValidator.hasValidCode(parameters.code))
          .thenReturn(true);
      when(() => mockAssetRepository.getAssetFloorDataByCode(parameters))
          .thenAnswer((_) async => const Right(expectedAsset));

      final result = await usecase(parameters);

      expect(result, equals(const Right(expectedAsset)));
      verify(() => mockAssetValidator.hasValidCode(parameters.code)).called(1);
      verify(() => mockAssetRepository.getAssetFloorDataByCode(parameters))
          .called(1);
      verifyNoMoreInteractions(mockAssetValidator);
      verifyNoMoreInteractions(mockAssetRepository);
    });

    test('should return InvalidAssetCodeFailure when code is invalid',
        () async {
      const parameters = AssetSearchParameters(code: 'INVALID_CODE');

      when(() => mockAssetValidator.hasValidCode(parameters.code))
          .thenReturn(false);

      final result = await usecase(parameters);

      expect(result, equals(const Left(InvalidAssetCodeFailure())));
      verify(() => mockAssetValidator.hasValidCode(parameters.code)).called(1);
      verifyNoMoreInteractions(mockAssetValidator);
      verifyNoMoreInteractions(mockAssetRepository);
    });

    test('should return AssetFailure on repository error', () async {
      const parameters = AssetSearchParameters(code: 'PETR4.SA');
      const expectedFailure = InvalidAssetCodeFailure();

      when(() => mockAssetValidator.hasValidCode(parameters.code))
          .thenReturn(true);
      when(() => mockAssetRepository.getAssetFloorDataByCode(parameters))
          .thenAnswer((_) async => const Left(expectedFailure));

      final result = await usecase(parameters);

      expect(result, equals(const Left(expectedFailure)));
      verify(() => mockAssetValidator.hasValidCode(parameters.code)).called(1);
      verify(() => mockAssetRepository.getAssetFloorDataByCode(parameters))
          .called(1);
      verifyNoMoreInteractions(mockAssetValidator);
      verifyNoMoreInteractions(mockAssetRepository);
    });
  });
}
