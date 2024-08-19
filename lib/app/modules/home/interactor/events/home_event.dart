import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_model.dart';
import 'package:effecti_challenge/app/utils/filter_enum.dart';

sealed class HomeEvent {}

class LoadTasksEvent extends HomeEvent {
  LoadTasksEvent();
}

class AddingTasksEvent extends HomeEvent {
  final String title;
  final String date;

  AddingTasksEvent(this.title, this.date);
}

class EditingTasksEvent extends HomeEvent {
  final TasksModel task;
  final int index;
  final String title;
  final String date;

  EditingTasksEvent(this.task, this.index, this.title, this.date);
}

class DeletingTasksEvent extends HomeEvent {
  final TasksModel task;

  DeletingTasksEvent(this.task);
}

class CompletingTasksEvent extends HomeEvent {
  final TasksModel task;
  final int index;

  CompletingTasksEvent(this.task, this.index);
}

class PendingTasksEvent extends HomeEvent {
  final TasksModel task;
  final int index;

  PendingTasksEvent(this.task, this.index);
}

class FilteringTasksEvent extends HomeEvent {
  final TasksListModel tasksList;
  Set<Filter> selection = <Filter>{Filter.all};

  FilteringTasksEvent(this.tasksList, this.selection);
}

class DeletingAllTasksEvent extends HomeEvent {
  DeletingAllTasksEvent();
}

class DueDateTasksEvent extends HomeEvent {
  final TasksListModel tasksList;

  DueDateTasksEvent(this.tasksList);
}
