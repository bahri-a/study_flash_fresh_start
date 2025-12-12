import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flash/src/core/providers/auth_provider.dart';
import 'package:study_flash/shell_screen.dart';
import 'package:study_flash/src/features/home/presentation/home_screen.dart';
import 'package:study_flash/src/features/login/login_screen.dart';
import 'package:study_flash/src/features/register/register_screen.dart';
import 'package:study_flash/src/features/study/presentation/study_screen.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: '/login', //Start URL

    redirect: (context, state) {
      final bool isLoggedIn = authState.value != null;
      final bool isOnLoginScreen = state.uri.toString() == '/login';
      final bool isOnRegisterScreen = state.uri.toString() == '/register';

      // Fall 1: Der User ist nicht eingeloggt => LoginScreen
      if (!isLoggedIn && !isOnLoginScreen && !isOnRegisterScreen) {
        return '/login';
      }

      // Fall 2: Der User ist eingeloggt => Home
      if (isLoggedIn && (isOnLoginScreen || isOnRegisterScreen)) {
        return '/';
      }

      // Fall 3: Keine Umleitung, wenn es kein Need gibt
      return null;
    },

    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return ShellScreen(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/', builder: (context, state) => HomeScreen()),
            ],
          ),

          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       path: '/Cardsscreen',
          //       builder: (context, state) => CardsScreen(),
          //     ),
          //   ],
          // ),

          // StatefulShellBranch(
          //   routes: [
          //     GoRoute(
          //       path: '/Chartsscreen',
          //       builder: (context, state) => ChartsScreen(),
          //     ),
          //   ],
          // ),
        ],
      ),

      // GoRoute(
      //   path: '/themenStudy/:fach',
      //   builder: (context, state) {
      //     final String fach = state.pathParameters['fach']!;
      //     final Color farbe = state.extra as Color;
      //     return ThemenScreenStudy(fachFarbe: farbe, fachName: fach);
      //   },
      // ),

      // GoRoute(
      //   path: '/themenCards/:fach',
      //   builder: (context, state) {
      //     final String fach = state.pathParameters['fach']!;
      //     final Color farbe = state.extra as Color;
      //     return ThemenScreenCards(fachFarbe: farbe, fachName: fach);
      //   },
      // ),

      // GoRoute(
      //   path: '/addFach',
      //   builder: (context, state) {
      //     return AddFachScreen();
      //   },
      // ),
      GoRoute(
        path: '/study',
        builder: (context, state) {
          return StudyScreen();
        },
      ),

      // GoRoute(
      //   path: '/edit/:fach/:thema',
      //   builder: (context, state) {
      //     final String fach = state.pathParameters['fach']!;
      //     final String thema = state.pathParameters['thema']!;
      //     final Color farbe = state.extra as Color;
      //     return EditScreenCards(
      //       farbe: farbe,
      //       fach: fach,
      //       thema: thema,
      //     );
      //   },
      // ),

      // GoRoute(
      //   path: '/chartsOfSubject/:fach',
      //   builder: (context, state) {
      //     final String fach = state.pathParameters['fach']!;
      //     final Color farbe = state.extra as Color;
      //     return chartsOfSubject(farbe: farbe, fach: fach);
      //   },
      // ),

      // GoRoute(
      //   path: '/settings',
      //   builder: (context, state) => DrawerMenu(),
      // ),

      // GoRoute(
      //   path: '/editCard/:fach/:thema',
      //   builder: (context, state) {
      //     final String fach = state.pathParameters['fach']!;
      //     final String thema = state.pathParameters['thema']!;
      //     final Color farbe = state.extra as Color;
      //     return Editcard(fach: fach, thema: thema, farbe: farbe);
      //   },
      // ),
      GoRoute(
        path: '/register',
        builder: (context, state) {
          return RegisterScreen();
        },
      ),

      GoRoute(
        path: '/login',
        builder: (context, state) {
          return LoginScreen();
        },
      ),
    ],
  );
});
