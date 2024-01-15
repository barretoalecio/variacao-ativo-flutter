import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:variacao_ativo/app/core/shared/domain/failures/failure.dart';
import 'package:variacao_ativo/app/core/shared/domain/parameters/zero_parameters.dart';
import 'package:variacao_ativo/app/core/utils/app_routes/asset_module_routes.dart';
import 'package:variacao_ativo/app/modules/coordinator/domain/entities/coordinator_result_entity.dart';

import 'package:variacao_ativo/app/modules/coordinator/domain/repositories/coordinator_repository.dart';
import 'package:variacao_ativo/app/modules/coordinator/domain/usecases/get_proper_route_to_navigate.dart';

class MockCoordinatorRepository extends Mock implements CoordinatorRepository {}

void main() {
  group('GetProperRouteToNavigate', () {
    late GetProperRouteToNavigate usecase;
    late MockCoordinatorRepository mockRepository;

    setUp(() {
      mockRepository = MockCoordinatorRepository();
      usecase = GetProperRouteToNavigateImplementation(mockRepository);
    });

    test('should return proper route when repository returns a result',
        () async {
      when(() => mockRepository.getProperRouteToNavigate()).thenAnswer(
        (_) async => const Right(
          CoordinatorResultEntity(
            properRouteToNavigate:
                '${AssetModuleRoutes.moduleName}${AssetModuleRoutes.initialRoute}',
          ),
        ),
      );

      final result = await usecase(const ZeroParameters());

      verify(() => mockRepository.getProperRouteToNavigate());

      expect(result, isA<Right<Failure, CoordinatorResultEntity>>());
    });

    test('should return CoordinatorFailure when repository throws an exception',
        () async {
      when(() => mockRepository.getProperRouteToNavigate()).thenAnswer(
        (_) async => throw Exception('Unable to get proper route to navigate'),
      );

      final result = await usecase(const ZeroParameters());

      verify(() => mockRepository.getProperRouteToNavigate());

      expect(result, isA<Left<Failure, CoordinatorResultEntity>>());
    });
  });
}
