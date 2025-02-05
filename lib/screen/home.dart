import 'package:flutter/material.dart';
import '../model/todo.dart';
import '../constant/color.dart';
import '../widgets/todo_item.dart';
import 'add_todo_page.dart';  

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final todosList = ToDo.todoList();
  List<ToDo> _foundToDo = [];
  List<ToDo> _completedToDo = [];
  List<ToDo> _pendingToDo = [];
  bool _showCompleted = false;  

  @override
  void initState() {
    _foundToDo = todosList;
    _filterTasks();
    super.initState();
  }

  void _filterTasks() {
    _completedToDo = todosList.where((todo) => todo.isDone).toList();
    _pendingToDo = todosList.where((todo) => !todo.isDone).toList();
  }

  void _toggleView(bool showCompletedTasks) {
    setState(() {
      _showCompleted = showCompletedTasks;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: tdBGColor,
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 15,
            ),
            child: Column(
              children: [
                searchBox(),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          top: 40,
                          bottom: 20,
                        ),
                        child: Text(
                          'Tasks List',
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10, bottom: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            ElevatedButton(
                              onPressed: () => _toggleView(false),
                              child: Text('Pending Tasks', 
                              style: TextStyle(color: !_showCompleted ? tdBGColor : tdBlack),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: !_showCompleted ? tdRed : tdBGColor, 
                              ),
                            ),
                            SizedBox(width: 10),

                            ElevatedButton(
                              onPressed: () => _toggleView(true),
                              child: Text('Completed Tasks', 
                              style: TextStyle(color: _showCompleted ? tdBGColor : tdBlack),),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _showCompleted ? tdGreen : tdBGColor, 
                              ),
                            ),
                          ],
                        ),
                      ),

                   if (!_showCompleted) 
                      for (ToDo todoo in _foundToDo.where((todo) => !todo.isDone).toList().reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),

                    if (_showCompleted)
                      for (ToDo todoo in _foundToDo.where((todo) => todo.isDone).toList().reversed)
                        ToDoItem(
                          todo: todoo,
                          onToDoChanged: _handleToDoChange,
                          onDeleteItem: _deleteToDoItem,
                        ),

                    ],
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,  
            child: Container(
              margin: EdgeInsets.only(
                bottom: 20,
                right: 20,
              ),
              child: ElevatedButton(
                child: Text(
                  '+',
                  style: TextStyle(
                    fontSize: 40,
                    color: tdBGColor,
                  ),
                ),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddToDoPage(
                        addToDo: _addToDoItem, 
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: tdBlue,
                  minimumSize: Size(60, 60),
                  elevation: 10,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
      _filterTasks(); 
    });
  }

  void _deleteToDoItem(String id) {
    setState(() {
      todosList.removeWhere((item) => item.id == id);
      _filterTasks();  
    });
  }

  void _addToDoItem(ToDo newToDo) {
    setState(() {
      todosList.add(newToDo); 
      _filterTasks();  
    });
  }

  void _runFilter(String enteredKeyword) {
    List<ToDo> results = [];
    if (enteredKeyword.isEmpty) {
      results = todosList;
    } else {
      results = todosList.where((item) =>
        item.todoText!.toLowerCase().contains(enteredKeyword.toLowerCase()))
        .toList();
    }

    setState(() {
      _foundToDo = results;
    });
  }

  Widget searchBox() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        onChanged: (value) => _runFilter(value),
        decoration: InputDecoration(
          contentPadding: EdgeInsets.all(0),
          prefixIcon: Icon(
            Icons.search,
            color: tdBlack,
            size: 20,
          ),
          prefixIconConstraints: BoxConstraints(
            maxHeight: 20,
            minWidth: 25,
          ),
          border: InputBorder.none,
          hintText: 'Search',
          hintStyle: TextStyle(color: tdGrey),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: tdBGColor,
      elevation: 0,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(
            Icons.list_alt_rounded,
            color: tdBlack,
            size: 30,
          ),
          SizedBox(width: 10),
          Text(
            'List App',
            style: TextStyle(
              color: tdBlack,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}