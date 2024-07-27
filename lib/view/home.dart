import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_todo/view/bottom_nav_bar.dart';
import 'package:riverpod_todo/viewmodel/bottom_nav_ctrl.dart';
import 'today_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class MainScreen extends ConsumerWidget {
  final titles = ["Today", "History", "Settings"];
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(GoRouterState.of(context).uri.toString()),
      ),
      body: IndexedStack(
        index: selectedIndex,
        children: [
          TodayScreen(),
          HistoryScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
