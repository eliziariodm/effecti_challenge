import 'dart:convert';
import 'dart:developer';

import 'package:effecti_challenge/app/data/local_storage.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/save_tasks_service.dart';
import 'package:effecti_challenge/app/utils/local_storage_keys.dart';

class SaveTasksServiceImpl implements SaveTasksService {
  final LocalStorage _localStorage;

  SaveTasksServiceImpl(this._localStorage);

  @override
  Future<TasksModel?> call(TasksModel tasksModel) async {
    try {
      await _localStorage.set<String>(
        LocalStorageKeys.title,
        tasksModel.title,
      );
      await _localStorage.set<String>(
        LocalStorageKeys.date,
        tasksModel.date,
      );
      await _localStorage.set<bool>(
        LocalStorageKeys.isCompleted,
        tasksModel.isCompleted,
      );
      await _localStorage.set<String>(
        LocalStorageKeys.filters,
        tasksModel.filter,
      );

      return tasksModel;
    } catch (e, s) {
      log('$e');
      log('$s');

      return null;
    }
  }

  @override
  Future<TasksListModel?> callTasksList(TasksListModel tasksListModel) async {
    try {
      await _localStorage.setList(
        LocalStorageKeys.tasksList,
        [jsonEncode(tasksListModel.tasksList)],
      );

      return tasksListModel;
    } catch (e, s) {
      log('$e');
      log('$s');

      return null;
    }
  }
}
