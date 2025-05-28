import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../models/task.dart';
import '../services/storage.dart';
import 'add_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  Future<void> _loadTasks() async {
    final tasks = await StorageService.loadTasks();
    setState(() => _tasks = tasks);
  }

  void _addTask() async {
    final newTask = await Navigator.push<Task>(
      context,
      MaterialPageRoute(builder: (context) => const AddTaskScreen()),
    );
    if (newTask != null) {
      setState(() => _tasks.add(newTask));
      await StorageService.saveTasks(_tasks);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task Manager'),
        actions: [IconButton(icon: const Icon(Icons.add), onPressed: _addTask)],
      ),
      body:
          _tasks.isEmpty
              ? const Center(child: Text('No tasks yet!'))
              : ListView.builder(
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 4.0,
                      horizontal: 8.0,
                    ),
                    child: Slidable(
                      key: Key(task.id),
                      endActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (_) async {
                              setState(() => _tasks.removeAt(index));
                              await StorageService.saveTasks(_tasks);
                            },
                            icon: Icons.delete,
                            backgroundColor: Colors.red,
                            label: 'Delete',
                          ),
                        ],
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Color(task.colorCode),
                          borderRadius: BorderRadius.circular(8),
                          boxShadow: [
                            BoxShadow(
                              // ignore: deprecated_member_use
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ListTile(
                          leading: Checkbox(
                            value: task.isCompleted,
                            onChanged: (value) async {
                              setState(() => task.isCompleted = value!);
                              await StorageService.saveTasks(_tasks);
                            },
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 16,
                              decoration:
                                  task.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
    );
  }
}
