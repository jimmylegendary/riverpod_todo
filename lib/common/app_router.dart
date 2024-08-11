import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/view/home.dart';
import 'package:riverpod_todo/view/settings_screen.dart';
import 'package:riverpod_todo/view/todo_history.dart';
import 'package:riverpod_todo/view/todos_screen.dart';
import 'package:riverpod_todo/viewmodel/bottom_nav_ctrl.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/todos',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            ref.read(navigationIndexProvider.notifier).movePage(state);
          });
          return MainScreen(
            child: child,
            pageName: state.matchedLocation,
          );
        },
        routes: [
          GoRoute(
            path: '/todos',
            pageBuilder: (context, state) => NoTransitionPage(
              child: TodosScreen(),
            ),
          ),
          GoRoute(
            path: '/history',
            pageBuilder: (context, state) => NoTransitionPage(
              child: TodoHistory(),
            ),
          ),
          GoRoute(
            path: '/settings',
            pageBuilder: (context, state) => NoTransitionPage(
              child: SettingsScreen(),
            ),
          ),
        ],
      ),
    ],
  );
});
