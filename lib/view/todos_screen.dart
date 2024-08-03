import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_todo/model/todo_item.dart';
import 'package:riverpod_todo/view/todo_item_card.dart';
import 'package:riverpod_todo/viewmodel/todos_ctrl.dart';

setTodoItemStartState(WidgetRef ref, DateTime date) {
  ref.read(todoItemProvider.notifier).updateStartDate(date);
}

setTodoItemDueState(WidgetRef ref, DateTime date) {
  ref.read(todoItemProvider.notifier).updateDueDate(date);
}

void showTodoInputSheet(
    BuildContext context,
    WidgetRef ref,
    Function(WidgetRef ref, DateTime date) setStartState,
    Function(WidgetRef ref, DateTime date) setDuetate) {
  final _summaryController = TextEditingController();
  final todoItem = ref.watch(todoItemProvider);
  final _startDate = todoItem.startDate;
  log(_startDate?.toString() ?? "null");
  final _dueDate = todoItem.dueDate;
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Wrap(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: _summaryController,
                    onChanged: (value) {
                      ref.read(todoItemProvider.notifier).updateSummary(value);
                    },
                    decoration: const InputDecoration(
                      labelText: 'Summary',
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () =>
                        _showCalendarDatePicker(context, ref, setStartState),
                    child: Text(_startDate == null
                        ? 'Select Start Date'
                        : DateFormat('yyyy/MM/dd').format(_startDate)),
                  ),
                  const SizedBox(height: 16.0),
                  TextButton(
                    onPressed: () =>
                        _showCalendarDatePicker(context, ref, setDuetate),
                    child: Text(
                      _dueDate == null
                          ? 'Select Due Date'
                          : DateFormat('yyyy/MM/dd').format(_dueDate),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );
}

void _showCalendarDatePicker(BuildContext context, WidgetRef ref,
    Function(WidgetRef ref, DateTime date) setDateState) {
  final todos = ref.watch(todosProvider);
  final selectedDate = todos.selectedDate;
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Select a date'),
        content: Container(
          width: 400,
          height: 400, // Adjust height as needed
          child: CalendarDatePicker(
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
            onDateChanged: (DateTime date) {
              setDateState(ref, date);
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ),
      );
    },
  );
}

class TodoAppBar extends ConsumerWidget implements PreferredSizeWidget {
  TodoAppBar({Key? key, required this.title});

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  final String title;

  _setDateState(WidgetRef ref, DateTime date) {
    ref.read(todosProvider.notifier).updateDate(date);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);
    final selectedDate = todos.selectedDate;
    return AppBar(
      title: Text(title),
      bottom: PreferredSize(
        preferredSize: preferredSize,
        child: Text(
          DateFormat('MM월 dd일').format(selectedDate ?? DateTime.now()),
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.calendar_today),
          onPressed: () => _showCalendarDatePicker(context, ref, _setDateState),
        ),
      ],
    );
  }
}

class TodosScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);
    final todoItems = todos.todoList;
    final hasTodoItems = (todoItems != null && todoItems.isNotEmpty);
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
