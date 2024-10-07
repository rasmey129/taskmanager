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
class Task{
  String name;
  bool isCompleted;

  Task({required this.name, this.isCompleted = false});
}
class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController taskController = TextEditingController();
  final List<Task> tasks = [];

  void addTask(){
    setState(() {
      if (taskController.text.isNotEmpty){
        tasks.add(Task(name: taskController.text));
        taskController.clear();
      }
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
              Expanded(child: TextField(
                controller: taskController,
                decoration: const InputDecoration(
                  labelText: 'Task Name',
                ),
              ),
            ),
            const SizedBox(width: 20),
            ElevatedButton(onPressed: addTask,
            child: const Text('Add'),
               ),
             ],
           ),
           Expanded(child: ListView.builder(itemCount: tasks.length,
           itemBuilder: (context, index) {
            final task = tasks[index];
            return ListTile(title: Text(task.name),
            );
           },)
           )
          ],
        ),
      )
    );
  }
}
