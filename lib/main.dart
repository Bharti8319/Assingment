import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:onboarding/Core/Directories.dart';
import 'package:onboarding/features/Onboarding/Design/onboarding.dart';
import 'package:onboarding/onboarding2.dart';


class AppRoutes {
  static const String home = '/';
  static const String feature = '/feature';
}

CustomTransitionPage<void> buildSlidePage({
  required BuildContext context,
  required GoRouterState state,
  required Widget child,
}) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 350),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.easeInOutCubic;

      final tween = Tween(begin: begin, end: end).chain(
        CurveTween(curve: curve),
      );

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

final GoRouter appRouter = GoRouter(
  initialLocation: AppRoutes.home,
  routes: [
    GoRoute(
      path: AppRoutes.home,
      pageBuilder: (context, state) => buildSlidePage(
        context: context,
        state: state,
        child: const AidlyOnboardingScreen(),
      ),
    ),
    GoRoute(
      path: AppRoutes.feature,
      pageBuilder: (context, state) => buildSlidePage(
        context: context,
        state: state,
        child: const AidlyOnboardingScreen2(),
      ),
    ),
  ],
);

void main() {
  runApp(const AidlyApp());
}

class AidlyApp extends StatelessWidget {
  const AidlyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Aidly',
      routerConfig: appRouter,
    );
  }
}