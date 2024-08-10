import 'dart:convert';

class TasksModel {
  final String title;
  final String date;
  final bool isCompleted;
  final String filter;

  TasksModel({
    required this.title,
    required this.date,
    this.isCompleted = false,
    this.filter = 'all',
  });

  factory TasksModel.fromMap(Map<String, dynamic> map) {
    return TasksModel(
      title: map['title'] ?? '',
      date: map['date'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      filter: map['filter'] ?? 'all',
    );
  }

  factory TasksModel.fromJson(String json) =>
      TasksModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'date': date,
      'isCompleted': isCompleted,
      'filter': filter,
    };
  }

  String toJson() => json.encode(toMap());

  factory TasksModel.empty() {
    return TasksModel(
      title: '',
      date: '',
      isCompleted: false,
      filter: 'all',
    );
  }

  TasksModel copyWith({
    String? title,
    String? date,
    bool? isCompleted,
    String? filter,
  }) {
    return TasksModel(
      title: title ?? this.title,
      date: date ?? this.date,
      isCompleted: isCompleted ?? this.isCompleted,
      filter: filter ?? this.filter,
    );
  }

  @override
  String toString() {
    return 'TasksModel(title: $title, date: $date, isCompleted: $isCompleted, filter: $filter)';
  }
}
