import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:gym/core/constants/app_constants.dart' show AppConstants;
import 'package:gym/presentation/pages/history_page.dart';
import 'package:gym/presentation/pages/home_page.dart' show HomePage;
import 'package:gym/presentation/pages/progress_page.dart';
import 'package:gym/presentation/pages/routines_page.dart';
import 'package:gym/presentation/pages/create_routine_basic_page.dart';
import 'package:gym/presentation/pages/create_routine_type_selection_page.dart';
import 'package:gym/presentation/pages/create_routine_exercises_page.dart';
import 'package:gym/presentation/pages/settings_page.dart';
import 'package:gym/presentation/pages/workout_page.dart';


class AppRouter {
  static final GoRouter _router = GoRouter(
    initialLocation: AppConstants.homeRoute,
    routes: [
      GoRoute(
        path: AppConstants.homeRoute,
        name: 'home',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppConstants.routinesRoute,
        name: 'routines',
        builder: (context, state) => const RoutinesPage(),
      ),
      GoRoute(
        path: AppConstants.createRoutineRoute,
        name: 'create-routine',
        builder: (context, state) => const CreateRoutineBasicPage(),
      ),
      GoRoute(
        path: AppConstants.createRoutineBasicRoute,
        name: 'create-routine-basic',
        builder: (context, state) => const CreateRoutineBasicPage(),
      ),
      GoRoute(
        path: AppConstants.createRoutineTypeSelectionRoute,
        name: 'create-routine-type-selection',
        builder: (context, state) => const CreateRoutineTypeSelectionPage(),
      ),
      GoRoute(
        path: AppConstants.createRoutineExercisesRoute,
        name: 'create-routine-exercises',
        builder: (context, state) => const CreateRoutineExercisesPage(),
      ),
      GoRoute(
        path: AppConstants.workoutRoute,
        name: 'workout',
        builder: (context, state) {
          final routineId = state.uri.queryParameters['routineId'];
          return WorkoutPage(routineId: routineId);
        },
      ),
      GoRoute(
        path: AppConstants.historyRoute,
        name: 'history',
        builder: (context, state) => const HistoryPage(),
      ),
      GoRoute(
        path: AppConstants.progressRoute,
        name: 'progress',
        builder: (context, state) => const ProgressPage(),
      ),
      GoRoute(
        path: AppConstants.settingsRoute,
        name: 'settings',
        builder: (context, state) => const SettingsPage(),
      ),
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 64,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 16),
            Text(
              '¡Ups! Página no encontrada',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 8),
            Text(
              'La página que buscas no existe.',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: () => context.go(AppConstants.homeRoute),
              child: const Text('Volver al inicio'),
            ),
          ],
        ),
      ),
    ),
  );

  static GoRouter get router => _router;
}
