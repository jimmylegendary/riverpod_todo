import 'package:flutter/material.dart';

@immutable
class TodoItem {
  TodoItem({
    this.id,
    required this.title,
    this.startDate,
    this.dueDate,
    this.isComplete,
  });

  TodoItem copyWith({
    int? newId,
    String? newtitle,
    DateTime? newstartDate,
    DateTime? newdueDate,
    bool? newIsComplete,
  }) {
    return TodoItem(
      id: newId ?? id,
      title: newtitle ?? title,
      startDate: newstartDate ?? startDate,
      dueDate: newdueDate ?? dueDate,
      isComplete: newIsComplete ?? isComplete,
    );
  }

  final int? id;
  final String title;
  final DateTime? startDate;
  final DateTime? dueDate;
  final bool? isComplete;
}
