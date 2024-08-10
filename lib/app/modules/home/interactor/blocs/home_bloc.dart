import 'package:effecti_challenge/app/modules/home/interactor/events/home_event.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/delete_tasks_service.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/load_tasks_service.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/save_tasks_service.dart';
import 'package:effecti_challenge/app/modules/home/interactor/states/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LoadTasksService _loadTasksService;
  final SaveTasksService _saveTasksService;
  final DeleteTasksService _deleteTasksService;

  HomeBloc(
    this._loadTasksService,
    this._saveTasksService,
    this._deleteTasksService,
  ) : super(InitialTasksState()) {
    on<LoadTasksEvent>(_handleLoadTasks);
    on<AddingTasksEvent>(_handleAddingTasksEvent);
    on<EditingTasksEvent>(_handleEditingTasksEvent);
    on<DeletingTasksEvent>(_handleDeletingTasksEvent);
    on<CompletingTasksEvent>(_handleCompletingTasksEvent);
    on<FilteringTasksEvent>(_handleFilteringTasksEvent);
    on<DeletingAllTasksEvent>(_handleDeletingAllTasksEvent);
  }

  TasksModel _internalTasksModel = TasksModel.empty();
  TasksListModel _internalTasksListModel = TasksListModel.empty();

  void _handleLoadTasks(
    LoadTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    final state = await _loadTasksService();
    _internalTasksModel = state.tasksModel;
    _internalTasksListModel = state.tasksListModel;

    emit(SuccessTasksState(
      _internalTasksModel,
      _internalTasksListModel,
    ));
  }

  void _handleAddingTasksEvent(
    AddingTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    var state = await _loadTasksService();
    _internalTasksListModel = state.tasksListModel;

    _internalTasksListModel.tasksList.add(
      TasksModel(title: event.title, date: event.date),
    );

    await _saveTasksService.callTasksList(_internalTasksListModel);

    emit(SuccessTasksState(
      TasksModel.empty(),
      _internalTasksListModel,
    ));
  }

  void _handleEditingTasksEvent(
    EditingTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _saveTasksService(TasksModel.empty());
    await _saveTasksService.callTasksList(TasksListModel.empty());

    var state = await _loadTasksService();
    _internalTasksModel = state.tasksModel;
    _internalTasksListModel = state.tasksListModel;

    emit(SuccessTasksState(
      _internalTasksModel,
      _internalTasksListModel,
    ));
  }

  void _handleDeletingTasksEvent(
    DeletingTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    event.tasksListModel.tasksList.removeWhere(
      (element) => element.title == event.title,
    );

    _internalTasksListModel = _internalTasksListModel.copyWith(
      tasksList: event.tasksListModel.tasksList,
    );

    final response = await _saveTasksService.callTasksList(
      _internalTasksListModel,
    );

    if (response != null) {
      emit(SuccessTasksState(
        TasksModel.empty(),
        _internalTasksListModel,
      ));
    }
  }

  void _handleCompletingTasksEvent(
    CompletingTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _saveTasksService(TasksModel.empty());
    await _saveTasksService.callTasksList(TasksListModel.empty());

    var state = await _loadTasksService();
    _internalTasksModel = state.tasksModel;
    _internalTasksListModel = state.tasksListModel;

    emit(SuccessTasksState(
      _internalTasksModel,
      _internalTasksListModel,
    ));
  }

  void _handleFilteringTasksEvent(
    FilteringTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _saveTasksService(TasksModel.empty());

    var state = await _loadTasksService();
    _internalTasksModel = state.tasksModel;
    _internalTasksListModel = state.tasksListModel;

    emit(SuccessTasksState(
      _internalTasksModel,
      _internalTasksListModel,
    ));
  }

  void _handleDeletingAllTasksEvent(
    DeletingAllTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _deleteTasksService(TasksListModel.empty());

    var state = await _loadTasksService();
    _internalTasksModel = state.tasksModel;
    _internalTasksListModel = state.tasksListModel;

    emit(SuccessTasksState(
      _internalTasksModel,
      _internalTasksListModel,
    ));
  }
}
