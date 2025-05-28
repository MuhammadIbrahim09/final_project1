class Task {
  final String id;
  final String title;
  bool isCompleted;
  final int colorCode;

  Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.colorCode = 0xFFE3F2FD, // Default light blue
  });

  factory Task.fromJson(String json) {
    final parts = json.split('|');
    return Task(
      id: parts[0],
      title: parts[1],
      isCompleted: parts[2] == 'true',
      colorCode: int.parse(parts[3]),
    );
  }

  String toJson() {
    return '$id|$title|$isCompleted|$colorCode';
  }
}
