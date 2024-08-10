import 'dart:convert';

import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_model.dart';

class DecodeTasks {
  static List<TasksModel> call(List<String> jsons) {
    List list = [];

    for (var json in jsons) {
      list = jsonDecode(json);
    }

    var listTasks = list.map((json) => TasksModel.fromJson(json)).toList();

    return listTasks;
  }
}
