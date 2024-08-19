import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/utils/filter_enum.dart';

sealed class HomeState {
  final TasksListModel tasksListModel;
  Set<Filter>? selection;

  HomeState(this.tasksListModel, [this.selection]);
}

class InitialTasksState extends HomeState {
  InitialTasksState() : super(TasksListModel.empty());
}

class SuccessTasksState extends HomeState {
  SuccessTasksState(super.tasksListModel, [super.selection]);
}

class ErrorTasksState extends HomeState {
  ErrorTasksState() : super(TasksListModel.empty());
}

class DueDateTasksState extends HomeState {
  DueDateTasksState(super.tasksListModel, [super.selection]);
}
