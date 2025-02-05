import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../constant/color.dart';

class ToDoItem extends StatelessWidget {
  final ToDo todo;
  final Function(ToDo) onToDoChanged;
  final Function(String) onDeleteItem;

  const ToDoItem({
    Key? key,
    required this.todo,
    required this.onToDoChanged,
    required this.onDeleteItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Row(
              children: [
                Checkbox(
                  value: todo.isDone,
                  onChanged: (value) {
                    onToDoChanged(todo);
                  },
                  activeColor: tdBlue,
                ),
                Expanded(
                  child: Text(
                    todo.todoText!,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: tdBlack,
                      decoration: todo.isDone ? TextDecoration.lineThrough : null,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Row(
              children: [
                Text(
                  "Due: ${todo.dueDate?.toLocal().toString().split(' ')[0]}", 
                  style: TextStyle(
                    fontSize: 14,
                    color: tdGrey,
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: _getPriorityColor(todo.priority),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    todo.priority!,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),

            Text(
              todo.description!,
              style: TextStyle(
                fontSize: 14,
                color: tdGrey,
              ),
            ),
            SizedBox(height: 10),

            Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                icon: Icon(Icons.delete, color: tdRed),
                onPressed: () {
                  onDeleteItem(todo.id!);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getPriorityColor(String? priority) {
    switch (priority) {
      case 'High':
        return Colors.red;
      case 'Medium':
        return Colors.orange;
      case 'Low':
      default:
        return Colors.green;
    }
  }
}