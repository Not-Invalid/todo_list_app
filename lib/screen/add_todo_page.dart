import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../constant/color.dart';

class AddToDoPage extends StatefulWidget {
  final Function(ToDo) addToDo;

  AddToDoPage({required this.addToDo});

  @override
  _AddToDoPageState createState() => _AddToDoPageState();
}

class _AddToDoPageState extends State<AddToDoPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  String? _selectedPriority;  
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: AppBar(
        title: Text("Add New ToDo", style: TextStyle(color: tdBGColor)),
        backgroundColor: tdBlue,
        iconTheme: IconThemeData(color: tdBGColor),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                hintText: 'Enter ToDo Title',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            SizedBox(height: 20),

            DropdownButtonFormField<String>(
              value: _selectedPriority,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedPriority = newValue!;
                });
              },
              decoration: InputDecoration(
                hintText: 'Select Priority',  
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              items: <DropdownMenuItem<String>>[
                DropdownMenuItem<String>(
                  value: 'Low',
                  child: Text('Low'),
                ),
                DropdownMenuItem<String>(
                  value: 'Medium',
                  child: Text('Medium'),
                ),
                DropdownMenuItem<String>(
                  value: 'High',
                  child: Text('High'),
                ),
              ],
              hint: Text('Select Priority', style: TextStyle(color: Colors.grey)),
            ),
            SizedBox(height: 20),

            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter Description',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              maxLines: 4,
            ),
            SizedBox(height: 20),

            TextField(
              controller: TextEditingController(
                text: "${_selectedDate.toLocal()}".split(' ')[0],
              ),
              readOnly: true,  
              decoration: InputDecoration(
                hintText: 'Select Due Date',
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
                suffixIcon: Icon(Icons.calendar_today, color: tdBlue),
              ),
              onTap: () => _selectDate(context), 
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (_titleController.text.isNotEmpty && _descriptionController.text.isNotEmpty) {
                  ToDo newToDo = ToDo(
                    id: DateTime.now().millisecondsSinceEpoch.toString(),
                    todoText: _titleController.text,
                    priority: _selectedPriority ?? 'Low',  
                    description: _descriptionController.text,
                    dueDate: _selectedDate,
                  );
                  widget.addToDo(newToDo);
                  Navigator.pop(context);
                }
              },
              child: Text('Add ToDo', style: TextStyle(color: tdBGColor)),
              style: ElevatedButton.styleFrom(
                backgroundColor: tdBlue,
                minimumSize: Size(double.infinity, 50),
              ),
            ),
          ],
        ),
      ),
    );
  }
}