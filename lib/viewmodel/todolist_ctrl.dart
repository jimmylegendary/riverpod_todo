import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_todo/model/todo_item.dart';

final todoListProvider = NotifierProvider<TodosViewModel, List<TodoItem>>(
  () => TodosViewModel(),
);

final todoItemProvider = NotifierProvider<TodoItemViewModel, TodoItem>(
  () => TodoItemViewModel(),
);

final selectedDateProvider = StateProvider<DateTime>((ref) {
  return DateTime.now();
});

final todoListByBeforeDateProvider = Provider<List<TodoItem>>((ref) {
  final todoList = ref.watch(todoListProvider);
  final items = todoList
      .where((todo) => todo.startDate!.compareTo(DateTime.now()) < 0)
      .toList();

  return items;
});

final todoListByDateProvider = Provider<Map<DateTime, List<TodoItem>>>((ref) {
  final todoListByBeforeDate = ref.watch(todoListByBeforeDateProvider);
  final items = <DateTime, List<TodoItem>>{};
  todoListByBeforeDate.forEach((todo) {
    final date = todo.startDate;
    if (date != null) {
      if (items.containsKey(date)) {
        items[date]?.add(todo);
      } else {
        items[date] = [todo];
      }
    }
  });

  return items;
});

class TodoItemViewModel extends Notifier<TodoItem> {
  @override
  TodoItem build() {
    return TodoItem(title: "");
  }

  reset() {
    state = TodoItem(title: "");
  }

  updateTodoItem(TodoItem todo) {
    state = todo;
  }
}

class TodosViewModel extends Notifier<List<TodoItem>> {
  @override
  List<TodoItem> build() {
    return [];
  }

  add(TodoItem todo) {
    todo = todo.copyWith(newId: state.length);
    state = [...state, todo];
  }

  updateTodo(TodoItem todo) {
    final index = state.indexWhere((item) => item.id == todo.id);
    state[index] = todo;
  }

  removeTodo(TodoItem todo) {
    final index = state.indexWhere((item) => item.id == todo.id);
    state.removeAt(index);
  }
}
