import 'package:flutter/material.dart';

@immutable
class TodoItem {
  TodoItem({
    this.id,
    required this.title,
    this.detail,
    this.startDate,
    this.dueDate,
    this.isComplete,
  });

  TodoItem copyWith({
    int? newId,
    String? newtitle,
    String? newDetail,
    DateTime? newstartDate,
    DateTime? newdueDate,
    bool? newIsComplete,
  }) {
    return TodoItem(
      id: newId ?? id,
      title: newtitle ?? title,
      detail: newDetail ?? detail,
      startDate: newstartDate ?? startDate,
      dueDate: newdueDate ?? dueDate,
      isComplete: newIsComplete ?? isComplete,
    );
  }

  final int? id;
  final String title;
  final String? detail;
  final DateTime? startDate;
  final DateTime? dueDate;
  final bool? isComplete;
}
