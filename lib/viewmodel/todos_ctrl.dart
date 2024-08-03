import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/model/todo_item.dart';
import 'package:riverpod_todo/model/todos.dart';

final todosProvider = NotifierProvider<TodosViewModel, Todos>(
  () => TodosViewModel(),
);

final todoItemProvider = NotifierProvider<TodoItemViewModel, TodoItem>(
  () => TodoItemViewModel(),
);

class TodoItemViewModel extends Notifier<TodoItem> {
  @override
  TodoItem build() {
    return TodoItem(title: "");
  }

  updateStartDate(DateTime date) {
    state = state.copyWith(newstartDate: date);
  }

  updateDueDate(DateTime date) {
    state = state.copyWith(newdueDate: date);
  }

  updateSummary(String summary) {
    state = state.copyWith(newtitle: summary);
  }
}

class TodosViewModel extends Notifier<Todos> {
  @override
  Todos build() {
    return Todos(
      selectedDate: DateTime.now(),
    );
  }

  updateDate(DateTime date) {
    state = state.copyWith(newDate: date);
  }
}
