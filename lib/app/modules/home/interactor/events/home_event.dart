import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_model.dart';

sealed class HomeEvent {}

class LoadTasksEvent extends HomeEvent {
  final int? initialStep;

  LoadTasksEvent([this.initialStep = 0]);
}

class AddingTasksEvent extends HomeEvent {
  final String title;
  final String date;

  AddingTasksEvent(this.title, this.date);
}

class EditingTasksEvent extends HomeEvent {
  final TasksModel tasksModel;

  EditingTasksEvent(this.tasksModel);
}

class DeletingTasksEvent extends HomeEvent {
  final TasksListModel tasksListModel;
  final String? title;

  DeletingTasksEvent(this.tasksListModel, this.title);
}

class CompletingTasksEvent extends HomeEvent {
  final TasksModel tasksModel;

  CompletingTasksEvent(this.tasksModel);
}

class FilteringTasksEvent extends HomeEvent {
  final TasksModel tasksModel;

  FilteringTasksEvent(this.tasksModel);
}

class DeletingAllTasksEvent extends HomeEvent {
  final TasksModel tasksModel;

  DeletingAllTasksEvent(this.tasksModel);
}
