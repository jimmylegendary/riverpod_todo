import 'package:flutter/material.dart';

@immutable
class TodoItem {
  TodoItem({
    required this.title,
    this.startDate,
    this.dueDate,
    this.todoStatus,
  });

  TodoItem copyWith({
    String? newtitle,
    DateTime? newstartDate,
    DateTime? newdueDate,
    bool? newtodoStatus,
  }) {
    return TodoItem(
      title: newtitle ?? title,
      startDate: newstartDate ?? startDate,
      dueDate: newdueDate ?? dueDate,
      todoStatus: newtodoStatus ?? todoStatus,
    );
  }

  final String title;
  final DateTime? startDate;
  final DateTime? dueDate;
  final bool? todoStatus;
}
