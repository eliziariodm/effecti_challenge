import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/data_service.dart';
import 'package:effecti_challenge/app/modules/home/interactor/crud/delete_tasks.dart';
import 'package:effecti_challenge/app/modules/home/interactor/crud/read_tasks.dart';
import 'package:effecti_challenge/app/modules/home/interactor/crud/create_update_tasks.dart';

class DataServiceImpl implements DataService {
  final ReadTasks _readTasks;
  final CreateUpdateTasks _createUpdateTasks;
  final DeleteTasks _deleteTasks;

  DataServiceImpl(
    this._readTasks,
    this._createUpdateTasks,
    this._deleteTasks,
  );

  @override
  Future<TasksListModel> readTasks() async {
    var list = await _readTasks();
    return list.tasksListModel;
  }

  @override
  Future<void> createUpdateTasks(TasksListModel tasksListModel) async {
    await _createUpdateTasks(tasksListModel);
  }

  @override
  Future<void> deleteTasks(TasksListModel tasksListModel) async {
    await _deleteTasks(tasksListModel);
  }
}
