import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:variacao_ativo/app/core/shared/domain/parameters/zero_parameters.dart';
import 'package:variacao_ativo/app/core/shared/presentation/controllers/states/abstractions/app_state.dart';
import 'package:variacao_ativo/app/core/shared/presentation/controllers/states/global_states/idle_state.dart';
import 'package:variacao_ativo/app/core/utils/app_routes/asset_module_routes.dart';
import 'package:variacao_ativo/app/modules/coordinator/domain/entities/coordinator_result_entity.dart';
import 'package:variacao_ativo/app/modules/coordinator/domain/failures/coordinator_failure.dart';
import 'package:variacao_ativo/app/modules/coordinator/domain/usecases/get_proper_route_to_navigate.dart';
import 'package:variacao_ativo/app/modules/coordinator/presentation/controllers/blocs/coordinator_bloc.dart';
import 'package:variacao_ativo/app/modules/coordinator/presentation/controllers/events/coordinator_events.dart';
import 'package:variacao_ativo/app/modules/coordinator/presentation/controllers/events/get_proper_route_to_navigate_event.dart';
import 'package:variacao_ativo/app/modules/coordinator/presentation/controllers/states/getting_proper_route_to_navigate_state.dart';
import 'package:variacao_ativo/app/modules/coordinator/presentation/controllers/states/successfully_got_proper_route_to_navigate_state.dart';
import 'package:variacao_ativo/app/modules/coordinator/presentation/controllers/states/unable_to_get_proper_route_to_navigate_state.dart';

class MockGetProperRouteToNavigate extends Mock
    implements GetProperRouteToNavigate {}

void main() {
  group('CoordinatorBloc', () {
    late CoordinatorBloc coordinatorBloc;
    late GetProperRouteToNavigate mockGetProperRouteToNavigate;

    setUp(() {
      mockGetProperRouteToNavigate = MockGetProperRouteToNavigate();
      coordinatorBloc = CoordinatorBloc(mockGetProperRouteToNavigate);
    });

    tearDown(() {
      coordinatorBloc.close();
    });

    test('should be a Bloc', () {
      expect(coordinatorBloc, isA<Bloc<CoordinatorEvents, AppState>>());
    });

    test('initial state should be IdleState', () {
      expect(coordinatorBloc.state, equals(IdleState()));
    });

    blocTest<CoordinatorBloc, AppState>(
      'emits [GettingProperRouteToNavigateState, SuccessfullyGotProperRouteToNavigateState] states for successful event',
      build: () {
        return coordinatorBloc;
      },
      act: (bloc) async {
        when(() => mockGetProperRouteToNavigate(const ZeroParameters()))
            .thenAnswer(
          (_) async => const Right(
            CoordinatorResultEntity(
              properRouteToNavigate:
                  '${AssetModuleRoutes.moduleName}${AssetModuleRoutes.initialRoute}',
            ),
          ),
        );

        bloc.add(const GetProperRouteToNavigateEvent());
        await untilCalled(
          () => mockGetProperRouteToNavigate(
            const ZeroParameters(),
          ),
        );
      },
      expect: () => <AppState>[
        GettingProperRouteToNavigateState(),
        const SuccessfullyGotProperRouteToNavigateState(
          CoordinatorResultEntity(
            properRouteToNavigate:
                '${AssetModuleRoutes.moduleName}${AssetModuleRoutes.initialRoute}',
          ),
        ),
      ],
    );

    blocTest<CoordinatorBloc, AppState>(
      'emits [GettingProperRouteToNavigateState, UnableToGetProperRouteToNavigateState] states for failed event',
      build: () {
        return coordinatorBloc;
      },
      act: (bloc) async {
        when(() => mockGetProperRouteToNavigate(const ZeroParameters()))
            .thenAnswer((_) async => const Left(CoordinatorFailure('Error')));

        bloc.add(const GetProperRouteToNavigateEvent());
        await untilCalled(
          () => mockGetProperRouteToNavigate(const ZeroParameters()),
        );
      },
      expect: () => <AppState>[
        GettingProperRouteToNavigateState(),
        UnableToGetProperRouteToNavigateState(),
      ],
    );
  });
}
