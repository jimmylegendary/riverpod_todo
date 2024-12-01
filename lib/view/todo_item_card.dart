import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_todo/model/todo_item.dart';
import 'package:riverpod_todo/viewmodel/todolist_ctrl.dart';

class TodoItemCard extends ConsumerWidget {
  TodoItemCard({Key? key, required this.todoData});

  Widget _buildDismissBackground(
      Alignment alignment, Color color, String text) {
    return Container(
      alignment: alignment,
      color: color,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        text,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }

  final TodoItem todoData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Dismissible(
      key: ValueKey(todoData.id),
      background: _buildDismissBackground(
          Alignment.centerLeft, Colors.green, 'Complete'),
      secondaryBackground:
          _buildDismissBackground(Alignment.centerRight, Colors.red, 'Remove'),
      onDismissed: (direction) {
        if (direction == DismissDirection.startToEnd) {
          final updateTodo = todoData.copyWith(newIsComplete: true);
          ref.read(todoListProvider.notifier).updateTodo(updateTodo);
        } else {
          ref.read(todoListProvider.notifier).removeTodo(todoData);
        }
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          title: Text(todoData.title,
              style: TextStyle(fontWeight: FontWeight.bold)),
          subtitle: Text(
              'Due: ${DateFormat('yyyy/MM/dd').format(todoData.dueDate!)}'),
          onTap: () {
            // 카드 클릭 시 작업 수행
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('${todoData.detail}')),
            );
          },
        ),
      ),
    );
  }
}
