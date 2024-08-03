import 'package:flutter/material.dart';
import 'package:riverpod_todo/model/todo_item.dart';

@immutable
class Todos {
  Todos({
    this.selectedDate,
    this.todoList,
  });

  Todos copyWith({DateTime? newDate, List<TodoItem>? newTodoList}) {
    return Todos(
      selectedDate: newDate ?? selectedDate,
      todoList: newTodoList ?? todoList,
    );
  }

  final DateTime? selectedDate;
  final List<TodoItem>? todoList;
}
