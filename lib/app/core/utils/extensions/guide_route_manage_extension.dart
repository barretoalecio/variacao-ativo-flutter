import 'package:animations/animations.dart';
import 'package:flutter_modular/flutter_modular.dart';

extension GuideRouteManageExtension on RouteManager {
  void guideChild(
    String name, {
    required ModularChild child,
    List<ParallelRoute> children = const [],
    Duration? duration,
    bool maintainState = true,
    List<RouteGuard> guards = const [],
  }) {
    add(
      ChildRoute(
        name,
        child: child,
        children: children,
        customTransition: CustomTransition(
          transitionDuration: const Duration(milliseconds: 400),
          transitionBuilder: (context, animation, secondaryAnimation, child) =>
              FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          ),
        ),
        duration: duration,
        transition: TransitionType.custom,
        maintainState: maintainState,
        guards: guards,
      ),
    );
  }

  void guideModule(
    String name, {
    required Module module,
    Duration? duration,
    List<RouteGuard> guards = const [],
  }) {
    add(
      ModuleRoute(
        name,
        module: module,
        customTransition: CustomTransition(
          transitionDuration: const Duration(milliseconds: 400),
          transitionBuilder: (context, animation, secondaryAnimation, child) =>
              FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          ),
        ),
        duration: duration,
        transition: TransitionType.custom,
        guards: guards,
      ),
    );
  }
}
