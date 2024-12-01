import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_todo/model/todo_item.dart';
import 'package:riverpod_todo/view/todo_input.dart';
import 'package:riverpod_todo/view/todo_item_card.dart';
import 'package:riverpod_todo/viewmodel/todolist_ctrl.dart';

void showTodoInputSheet(
  BuildContext context,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) => TodoInput(),
  );
}

class TodoAppBar extends ConsumerWidget implements PreferredSizeWidget {
  TodoAppBar({Key? key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  final String title;

  _setDateState(WidgetRef ref, DateTime date) {
    ref.read(selectedDateProvider.notifier).state = date;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDate = ref.watch(selectedDateProvider);
    return AppBar(
      title: Text(title),
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: Text(
          DateFormat('MM월 dd일').format(selectedDate),
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => showCalendarDatePicker(context, ref, _setDateState),
        ),
      ],
    );
  }
}

class TodosScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoItems = ref.watch(todoListProvider);
    final hasTodoItems = todoItems.isNotEmpty;
    return hasTodoItems
        ? ListView.builder(
            itemCount: todoItems.length,
            itemBuilder: (context, index) {
              final todoItem = todoItems.elementAt(index);
              return TodoItemCard(
                todoData: todoItem,
              );
            },
          )
        : const Center(
            child: Text("No todo items found"),
          );
  }
}
