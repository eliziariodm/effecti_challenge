import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_model.dart';

abstract interface class SaveTasksService {
  Future<TasksModel?> call(TasksModel tasksModel);

  Future<TasksListModel?> callTasksList(TasksListModel tasksListModel);
}
