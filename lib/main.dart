import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Task Manager'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Task{ //class for the task list
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}
class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController taskController = TextEditingController();
  final List<Task> tasks = []; //list for the task

  void addTask(){ //add function 
    setState(() {
      if (taskController.text.isNotEmpty){
        tasks.add(Task(name: taskController.text));
        taskController.clear();
      }
    });
  }

  void taskCompletion(Task task){
    setState(() { //function to check off the task 
      task.isCompleted = !task.isCompleted;
    });
  }

  void removeTask(Task task){
    setState(() { //function to delete the task
      tasks.remove(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(children: [ 
              Expanded(child: TextField( //textfield for the task input
                controller: taskController,
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                ),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(onPressed: addTask, //add task button 
            child: const Text('Add'), 
               ),
             ],
           ),
           Expanded(child: ListView.builder(itemCount: tasks.length,
           itemBuilder: (context, index) { //list builder to display the task as each of its own element
            final task = tasks[index];
            return ListTile(title: Text(
              task.name, style: TextStyle(
              decoration: task.isCompleted ? TextDecoration.lineThrough: null,
              ),
            ),
            leading: Checkbox(
              value: task.isCompleted,
              onChanged: (bool? value){ //check box for the complete and check
                taskCompletion(task);
              },
            ),
            trailing: TextButton(
              onPressed: () => removeTask(task), //delete button 
               child: const Text('Delete', 
               style: TextStyle(color: Colors.red),))   
            );
           },)
           )
          ],
        ),
      )
    );
  }
}
