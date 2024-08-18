import 'dart:developer';

import 'package:effecti_challenge/app/data/local_storage.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/crud/delete_tasks.dart';
import 'package:effecti_challenge/app/utils/local_storage_keys.dart';

class DeleteTasksImpl implements DeleteTasks {
  final LocalStorage _localStorage;

  DeleteTasksImpl(this._localStorage);

  @override
  Future<TasksListModel?> call(TasksListModel tasksListModel) async {
    try {
      await _localStorage.delete(
        LocalStorageKeys.tasksList,
      );

      return tasksListModel;
    } catch (e, s) {
      log('$e');
      log('$s');

      return null;
    }
  }
}
