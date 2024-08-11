import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';

abstract interface class SaveTasksService {
  Future<TasksListModel?> call(TasksListModel tasksListModel);
}
