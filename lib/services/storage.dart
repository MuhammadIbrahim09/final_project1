import 'package:shared_preferences/shared_preferences.dart';
import '../models/task.dart';

class StorageService {
  static const _tasksKey = 'tasks';

  static Future<List<Task>> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksJson = prefs.getStringList(_tasksKey);

    if (tasksJson == null || tasksJson.isEmpty) {
      final defaultTasks = _createDefaultTasks();
      await saveTasks(defaultTasks);
      return defaultTasks;
    }

    return tasksJson.map((json) => Task.fromJson(json)).toList();
  }

  static List<Task> _createDefaultTasks() {
    return [
      Task(
        id: '1',
        title: 'Complete Flutter Internship',
        colorCode: 0xFFFFCDD2, // Red
      ),
      Task(
        id: '2',
        title: 'Prepare Final Presentation',
        colorCode: 0xFFC8E6C9, // Green
      ),
      Task(
        id: '3',
        title: 'Submit Weekly Report',
        colorCode: 0xFFFFF9C4, // Yellow
      ),
    ];
  }

  static Future<void> saveTasks(List<Task> tasks) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _tasksKey,
      tasks.map((task) => task.toJson()).toList(),
    );
  }
}
