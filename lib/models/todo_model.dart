class TodoModel {
  final String title;
  final DateTime createdAt;
  bool isDone;

  TodoModel({
    required this.title,
    required this.createdAt,
    required this.isDone,
  });
}
