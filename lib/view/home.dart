import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_todo/common/app_router.dart';
import 'package:riverpod_todo/view/bottom_nav_bar.dart';
import 'package:riverpod_todo/viewmodel/bottom_nav_ctrl.dart';
import 'todos_screen.dart';
import 'history_screen.dart';
import 'settings_screen.dart';

class MainScreen extends ConsumerWidget {
  MainScreen({Key? key, required this.child, required this.pageName});
  final Widget child;
  final String pageName;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: TodoAppBar(
        title: pageName.substring(1),
      ),
      body: child,
      bottomNavigationBar: CustomBottomNavigationBar(),
      floatingActionButton: FloatingActionButton(
        // onPressed: () => {},
        onPressed: () => showTodoInputSheet(
            context, ref, setTodoItemStartState, setTodoItemDueState),
        child: Icon(Icons.add),
      ),
    );
  }
}
