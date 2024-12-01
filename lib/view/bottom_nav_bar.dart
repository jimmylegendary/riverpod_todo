import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_todo/common/app_router.dart';
import 'package:riverpod_todo/viewmodel/bottom_nav_ctrl.dart';

class CustomBottomNavigationBar extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);

    return BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/todos');
            break;
          case 1:
            context.go('/history');
            break;
          case 2:
            context.go('/settings');
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.today), label: "Todos"),
        BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
