import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_model.dart';

sealed class HomeState {
  final TasksModel tasksModel;
  final TasksListModel tasksListModel;

  HomeState(this.tasksModel, this.tasksListModel);
}

class InitialTasksState extends HomeState {
  InitialTasksState() : super(TasksModel.empty(), TasksListModel.empty());
}

class SuccessTasksState extends HomeState {
  SuccessTasksState(super.tasksModel, super.tasksListModel);
}

class ErrorTasksState extends HomeState {
  ErrorTasksState() : super(TasksModel.empty(), TasksListModel.empty());
}
