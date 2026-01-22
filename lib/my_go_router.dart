import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:study_flash/src/core/models/topic/topic.dart';
import 'package:study_flash/src/core/providers/auth_provider.dart';
import 'package:study_flash/shell_screen.dart';
import 'package:study_flash/src/features/cards/cards_screen.dart';
import 'package:study_flash/src/features/cards/cards_topics_screen.dart';
import 'package:study_flash/src/features/home/presentation/home_screen.dart';
import 'package:study_flash/src/features/login/login_screen.dart';
import 'package:study_flash/src/features/register/register_screen.dart';
import 'package:study_flash/src/features/study/presentation/add_flashcard_screen.dart';
import 'package:study_flash/src/features/study/presentation/study_screen.dart';
import 'package:study_flash/src/features/study/presentation/studytopics_screen.dart';

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
            routes: [GoRoute(path: '/', builder: (context, state) => HomeScreen())],
          ),

          StatefulShellBranch(
            routes: [GoRoute(path: '/cardsscreen', builder: (context, state) => CardsScreen())],
          ),

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
        path: '/study/:subjectId/:topicId',
        builder: (context, state) {
          final String subjectId = state.pathParameters['subjectId']!;
          final String topicId = state.pathParameters['topicId']!;
          return StudyScreen(subjectId: subjectId, topicId: topicId);
        },
      ),

      GoRoute(
        path: '/addFlashcardScreen/:subjectId/:topicId',
        builder: (context, state) {
          final params = (
            subjectId: state.pathParameters['subjectId']!,
            topicId: state.pathParameters['topicId']!,
          );
          return AddFlashcardScreen(params: params);
        },
      ),

      GoRoute(
        path: '/cardsscreen',
        builder: (context, state) {
          return CardsScreen();
        },
      ),

      GoRoute(
        path: '/cardstopics/:subjectId/:subjectName',
        builder: (context, state) {
          final String subjectId = state.pathParameters['subjectId']!;
          final String subjectName = state.pathParameters['subjectName']!;
          return CardsTopics(subjectId: subjectId, subjectName: subjectName);
        },
      ),

      GoRoute(
        path: '/studytopics/:subjectId',
        builder: (context, state) {
          final String subjectId = state.pathParameters['subjectId']!;
          return StudytopicsScreen(subjectId: subjectId);
        },
      ),

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
