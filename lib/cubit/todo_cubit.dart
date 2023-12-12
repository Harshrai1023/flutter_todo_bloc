import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../models/todo_model.dart';

class TodoCubit extends HydratedCubit<List<TodoModel>> {
  TodoCubit() : super([]);
  void addTodo(String title) {
    final todo = TodoModel(
      title: title,
      createdAt: DateTime.now(),
      isDone: false,
    );
    emit([...state, todo]);
  }

  void removeTodo(DateTime createdAt) {
    state.removeWhere(
      (element) => element.createdAt == createdAt,
    );
    emit([...state]);
  }

  void completeTodo(DateTime createdAt) {
    final todo = state.firstWhere((element) => element.createdAt == createdAt);
    todo.isDone = !todo.isDone;
    emit([...state]);
  }

  @override
  List<TodoModel>? fromJson(Map<String, dynamic> json) {
    if (json.containsKey('todos')) {
      List<dynamic> todosJson = json['todos'];
      return todosJson
          .map((todoJson) => TodoModel(
                title: todoJson['title'],
                createdAt: DateTime.parse(todoJson['createdAt']),
                isDone: todoJson['isDone'],
              ))
          .toList();
    }
    return null;
  }

  @override
  Map<String, dynamic>? toJson(List<TodoModel> state) {
    return {
      'todos': state
          .map((todo) => {
                'title': todo.title,
                'createdAt': todo.createdAt.toIso8601String(),
                'isDone': todo.isDone,
              })
          .toList(),
    };
  }
}
