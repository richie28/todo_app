import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'dart:convert';

import 'package:todo_app/models/todo.dart';

class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  final storage = GetStorage();
  final storageKey = 'todoList';

  @override
  void onInit() {
    super.onInit();
    loadTodos();
  }

  void addTodo(String title) {
    if (title.trim().isEmpty) return;

    todos.insert(0, Todo(title: title));
    saveTodos();
    todos.refresh();
  }


  void toggleTodoStatus(int index) {
    todos[index].isDone = !todos[index].isDone;
    saveTodos();
    todos.refresh();
  }

  void saveTodos() {
    final todoList = todos.map((todo) => todo.toJson()).toList();
    storage.write(storageKey, jsonEncode(todoList));
  }

  void loadTodos() {
    final data = storage.read(storageKey);
    if (data != null) {
      final decoded = jsonDecode(data) as List;
      todos.value = decoded.map((e) => Todo.fromJson(e)).toList();
    }
  }
}
