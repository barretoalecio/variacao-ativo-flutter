import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:variacao_ativo/app/core/shared/domain/failures/failure.dart';
import 'package:variacao_ativo/app/modules/coordinator/domain/entities/coordinator_result_entity.dart';
import 'package:variacao_ativo/app/modules/coordinator/domain/failures/coordinator_failure.dart';
import 'package:variacao_ativo/app/modules/coordinator/domain/repositories/coordinator_repository.dart';
import 'package:variacao_ativo/app/modules/coordinator/infrastructure/repositories/coordinator_repository_implementation.dart';

void main() {
  group('CoordinatorRepository', () {
    late CoordinatorRepository repository;

    setUp(() {
      repository = const CoordinatorRepositoryImplementation();
    });

    test('should return proper route to navigate', () async {
      final result = await repository.getProperRouteToNavigate();

      expect(result, isA<Right<Failure, CoordinatorResultEntity>>());

      result.fold(
        (failure) => fail('Expected Right, but got Left: $failure'),
        (data) {
          expect(data.properRouteToNavigate, isNotNull);
        },
      );
    });

    test('should return CoordinatorFailure on error', () async {
      const errorRepository = CoordinatorRepositoryImplementationWithError();
      final result = await errorRepository.getProperRouteToNavigate();

      expect(result, isA<Left<Failure, CoordinatorResultEntity>>());

      result.fold(
        (failure) {
          expect(failure, isA<CoordinatorFailure>());
        },
        (data) => fail('Expected Left, but got Right: $data'),
      );
    });
  });
}

class CoordinatorRepositoryImplementationWithError
    extends CoordinatorRepositoryImplementation {
  const CoordinatorRepositoryImplementationWithError();

  @override
  Future<Either<Failure, CoordinatorResultEntity>>
      getProperRouteToNavigate() async {
    return const Left(CoordinatorFailure('Error'));
  }
}
