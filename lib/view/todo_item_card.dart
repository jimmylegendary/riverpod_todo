import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/model/todo_item.dart';

class TodoItemCard extends ConsumerWidget {
  TodoItemCard({Key? key, required this.todoData});

  final TodoItem todoData;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      child: Text(todoData.title),
    );
  }
}
