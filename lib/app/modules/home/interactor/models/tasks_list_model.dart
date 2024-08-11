import 'dart:convert';

import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_model.dart';

class TasksListModel {
  final List<TasksModel> tasksList;

  TasksListModel({required this.tasksList});

  factory TasksListModel.fromMap(Map<String, dynamic> map) {
    return TasksListModel(
      tasksList: map['tasks_list'] ?? <TasksModel>[],
    );
  }

  factory TasksListModel.fromJson(String json) =>
      TasksListModel.fromMap(jsonDecode(json));

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'tasksList': tasksList.map((x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory TasksListModel.empty() {
    return TasksListModel(tasksList: <TasksModel>[]);
  }

  TasksListModel copyWith({
    List<TasksModel>? tasksList,
  }) {
    return TasksListModel(
      tasksList: tasksList ?? this.tasksList,
    );
  }

  @override
  String toString() => 'TasksListModel(tasksList: $tasksList)';
}
