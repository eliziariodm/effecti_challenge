import 'dart:developer';

import 'package:effecti_challenge/app/data/local_storage.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/load_tasks_service.dart';
import 'package:effecti_challenge/app/modules/home/interactor/states/home_state.dart';
import 'package:effecti_challenge/app/utils/decode_tasks.dart';
import 'package:effecti_challenge/app/utils/local_storage_keys.dart';

class LoadTasksServiceImpl implements LoadTasksService {
  final LocalStorage _localStorage;

  LoadTasksServiceImpl(this._localStorage);

  @override
  Future<HomeState> call() async {
    try {
      final tasksList = await _localStorage.getList(
            LocalStorageKeys.tasksList,
          ) ??
          [];

      return SuccessTasksState(
        TasksListModel(
          tasksList: DecodeTasks.call(tasksList),
        ),
      );
    } catch (e, s) {
      log('$e');
      log('$s');

      return ErrorTasksState();
    }
  }
}
