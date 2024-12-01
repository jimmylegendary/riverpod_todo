import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_todo/model/todo_item.dart';
import 'package:riverpod_todo/view/todo_item_card.dart';
import 'package:riverpod_todo/viewmodel/todolist_ctrl.dart';

class InnerListView extends ConsumerWidget {
  final List<TodoItem> items;

  InnerListView({required this.items});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final todo = items[index];
        return TodoItemCard(todoData: todo);
      },
    );
  }
}

class TodoHistory extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoListByDate = ref.watch(todoListByDateProvider);
    return ListView.builder(
      itemCount: todoListByDate.keys.length,
      itemBuilder: (context, index) {
        final date = todoListByDate.keys.elementAt(index);
        final items = todoListByDate[date];

        return (items == null || items.isEmpty)
            ? Container()
            : ListView(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      DateTime.now().difference(date).inDays == 0
                          ? "Today"
                          : DateTime.now().difference(date).inDays == -1
                              ? "Tomorrow"
                              : DateFormat('yyyy/MM/dd').format(date),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                  InnerListView(items: items),
                ],
              );
      },
    );
  }
}
