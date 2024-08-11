import 'dart:convert';
import 'dart:developer';

import 'package:effecti_challenge/app/data/local_storage.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/save_tasks_service.dart';
import 'package:effecti_challenge/app/utils/local_storage_keys.dart';

class SaveTasksServiceImpl implements SaveTasksService {
  final LocalStorage _localStorage;

  SaveTasksServiceImpl(this._localStorage);

  @override
  Future<TasksListModel?> call(TasksListModel tasksListModel) async {
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
