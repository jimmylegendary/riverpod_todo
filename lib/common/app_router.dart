import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/view/history_screen.dart';
import 'package:riverpod_todo/view/home.dart';
import 'package:riverpod_todo/view/settings_screen.dart';
import 'package:riverpod_todo/view/today_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/today',
    routes: [
      ShellRoute(
        builder: (context, state, child) {
          return MainScreen();
        },
        routes: [
          GoRoute(
            path: '/today',
            builder: (context, state) => TodayScreen(),
          ),
          GoRoute(
            path: '/history',
            builder: (context, state) => HistoryScreen(),
          ),
          GoRoute(
            path: '/settings',
            builder: (context, state) => SettingsScreen(),
          ),
        ],
      ),
    ],
  );
});
