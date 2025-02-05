class ToDo {
  String? id;
  String? todoText;
  String? priority; 
  String? description;
  bool isDone;
  DateTime? dueDate;

  ToDo({
    required this.id,
    required this.todoText,
    this.priority = 'Low',
    this.description = '',
    this.isDone = false,
    this.dueDate,
  });

  static List<ToDo> todoList() {
    return [
    ];
  }
}
