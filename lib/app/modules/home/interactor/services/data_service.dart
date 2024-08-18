import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';

abstract interface class DataService {
  Future<TasksListModel> readTasks();

  Future<void> createUpdateTasks(TasksListModel tasksListModel);

  Future<void> deleteTasks(TasksListModel tasksListModel);
}
