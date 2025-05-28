import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _controller = TextEditingController();
  int _selectedColor = 0xFFE3F2FD; // Default blue

  final List<int> _colorOptions = [
    0xFFFFCDD2, // Red
    0xFFC8E6C9, // Green
    0xFFFFF9C4, // Yellow
    0xFFE3F2FD, // Blue
    0xFFD1C4E9, // Purple
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Task')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task Title',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: 'Enter task description',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Task Color',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 12,
              children:
                  _colorOptions
                      .map((color) => _buildColorChoice(color))
                      .toList(),
            ),
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (_controller.text.isNotEmpty) {
                    Navigator.pop(
                      context,
                      Task(
                        id: DateTime.now().millisecondsSinceEpoch.toString(),
                        title: _controller.text,
                        colorCode: _selectedColor,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 32,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text('Save Task', style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorChoice(int colorCode) {
    return GestureDetector(
      onTap: () => setState(() => _selectedColor = colorCode),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: Color(colorCode),
          border:
              _selectedColor == colorCode
                  ? Border.all(width: 3, color: Colors.black)
                  : null,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
