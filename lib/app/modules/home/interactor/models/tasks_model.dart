import 'dart:convert';

class TasksModel {
  final String title;
  final String date;
  final bool isCompleted;
  final bool isExpired;

  TasksModel({
    required this.title,
    required this.date,
    this.isCompleted = false,
    this.isExpired = false,
  });

  factory TasksModel.fromMap(Map<String, dynamic> map) {
    return TasksModel(
      title: map['title'] ?? '',
      date: map['date'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      isExpired: map['isExpired'] ?? false,
    );
  }

  factory TasksModel.fromJson(String json) =>
      TasksModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'date': date,
      'isCompleted': isCompleted,
      'isExpired': isExpired,
    };
  }

  String toJson() => json.encode(toMap());

  factory TasksModel.empty() {
    return TasksModel(
      title: '',
      date: '',
      isCompleted: false,
      isExpired: false,
    );
  }

  TasksModel copyWith({
    String? title,
    String? date,
    bool? isCompleted,
    bool? isExpired,
  }) {
    return TasksModel(
      title: title ?? this.title,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      isExpired: isExpired ?? this.isExpired,
    );
  }

  @override
  String toString() {
    return 'TasksModel(title: $title, date: $date, isCompleted: $isCompleted, isExpired: $isExpired)';
  }
}
