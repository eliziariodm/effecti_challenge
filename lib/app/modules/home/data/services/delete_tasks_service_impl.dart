import 'dart:developer';

import 'package:effecti_challenge/app/data/local_storage.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/delete_tasks_service.dart';
import 'package:effecti_challenge/app/utils/local_storage_keys.dart';

class DeleteTasksServiceImpl implements DeleteTasksService {
  final LocalStorage _localStorage;

  DeleteTasksServiceImpl(this._localStorage);

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
