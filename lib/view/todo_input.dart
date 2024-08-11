import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_todo/viewmodel/todolist_ctrl.dart';

void showCalendarDatePicker(
  BuildContext context,
  WidgetRef ref,
  Function(WidgetRef ref, DateTime date) setDateState, {
  FormFieldState<DateTime>? field,
}) {
  final selectedDate = ref.watch(selectedDateProvider);
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
              field?.didChange(date);
              Navigator.of(context).pop(); // Close the dialog
            },
          ),
        ),
      );
    },
  );
}

class TodoInput extends ConsumerWidget {
  final _summaryController = TextEditingController();
  final todoInputFormKey = GlobalKey<FormState>();

  setTodoItemStartState(WidgetRef ref, DateTime date) {
    final updatedTodo = ref.read(todoItemProvider).copyWith(newstartDate: date);
    ref.read(todoItemProvider.notifier).updateTodoItem(updatedTodo);
  }

  setTodoItemDueState(WidgetRef ref, DateTime date) {
    final updatedTodo = ref.read(todoItemProvider).copyWith(newdueDate: date);
    ref.read(todoItemProvider.notifier).updateTodoItem(updatedTodo);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoItem = ref.watch(todoItemProvider);
    final _startDate = todoItem.startDate;
    final _dueDate = todoItem.dueDate;
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Wrap(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: todoInputFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextFormField(
                    controller: _summaryController,
                    onChanged: (value) {
                      final updatedTodo =
                          ref.read(todoItemProvider).copyWith(newtitle: value);
                      ref
                          .read(todoItemProvider.notifier)
                          .updateTodoItem(updatedTodo);
                    },
                    onFieldSubmitted: (value) {
                      if (todoInputFormKey.currentState?.validate() == true) {
                        final todoItem = ref.read(todoItemProvider);
                        ref.read(todoListProvider.notifier).add(todoItem);
                        Navigator.of(context).pop(); // Close the dialog
                      }
                    },
                    decoration: const InputDecoration(
                      labelText: 'Summary',
                    ),
                    validator: (value) => (value == null || value.isEmpty)
                        ? "Type todo summary"
                        : null,
                  ),
                  const SizedBox(height: 16.0),
                  FormField<DateTime>(
                    validator: (value) {
                      if (value == null) {
                        return "Select Start Date";
                      } else if (_dueDate != null &&
                          value.compareTo(_dueDate) > 0) {
                        return "Start Date should be before Due Date";
                      }
                      return null;
                    },
                    builder: (field) {
                      return Column(
                        children: [
                          TextButton(
                            onPressed: () => showCalendarDatePicker(
                                context, ref, setTodoItemStartState,
                                field: field),
                            child: Text(_startDate == null
                                ? 'Select Start Date'
                                : DateFormat('yyyy/MM/dd').format(_startDate!)),
                          ),
                          if (field.hasError)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                field.errorText!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  FormField<DateTime>(
                    validator: (value) {
                      if (value == null) {
                        return "Select Due Date";
                      }
                      return null;
                    },
                    builder: (field) {
                      return Column(
                        children: [
                          TextButton(
                            onPressed: () => showCalendarDatePicker(
                                context, ref, setTodoItemDueState,
                                field: field),
                            child: Text(
                              _dueDate == null
                                  ? 'Select Due Date'
                                  : DateFormat('yyyy/MM/dd').format(_dueDate!),
                            ),
                          ),
                          if (field.hasError)
                            Padding(
                              padding: const EdgeInsets.only(top: 8.0),
                              child: Text(
                                field.errorText!,
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                        ],
                      );
                    },
                  ),
                  const SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () {
                      if (todoInputFormKey.currentState?.validate() == true) {
                        final todoItem = ref.read(todoItemProvider);
                        ref.read(todoListProvider.notifier).add(todoItem);
                        Navigator.of(context).pop(); // Close the dialog
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
