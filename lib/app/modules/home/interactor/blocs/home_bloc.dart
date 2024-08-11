import 'package:effecti_challenge/app/modules/home/interactor/events/home_event.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/delete_tasks_service.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/load_tasks_service.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/save_tasks_service.dart';
import 'package:effecti_challenge/app/modules/home/interactor/states/home_state.dart';
import 'package:effecti_challenge/app/utils/filter_enum.dart';
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
    on<PendingTasksEvent>(_handlePendingTasksEvent);
    on<FilteringTasksEvent>(_handleFilteringTasksEvent);
    on<DeletingAllTasksEvent>(_handleDeletingAllTasksEvent);
  }

  TasksListModel _internalTasksListModel = TasksListModel.empty();

  void _handleLoadTasks(
    LoadTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    final state = await _loadTasksService();
    _internalTasksListModel = state.tasksListModel;

    emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
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

    await _saveTasksService(_internalTasksListModel);

    emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
  }

  void _handleEditingTasksEvent(
    EditingTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    var state = await _loadTasksService();
    _internalTasksListModel = state.tasksListModel;

    _internalTasksListModel.tasksList.removeWhere(
      (e) => e.title == event.task.title,
    );

    _internalTasksListModel.tasksList.insert(
      event.index,
      TasksModel(
        title: event.title,
        date: event.date,
        isCompleted: event.task.isCompleted,
      ),
    );

    await _saveTasksService(_internalTasksListModel);

    emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
  }

  void _handleDeletingTasksEvent(
    DeletingTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    var state = await _loadTasksService();
    _internalTasksListModel = state.tasksListModel;

    _internalTasksListModel.tasksList.removeWhere(
      (e) => e.title == event.task.title,
    );

    await _saveTasksService(_internalTasksListModel);

    emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
  }

  void _handleCompletingTasksEvent(
    CompletingTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    var state = await _loadTasksService();
    _internalTasksListModel = state.tasksListModel;

    _internalTasksListModel.tasksList.removeWhere(
      (e) => e.title == event.task.title,
    );

    _internalTasksListModel.tasksList.insert(
      event.index,
      TasksModel(
        title: event.task.title,
        date: event.task.date,
        isCompleted: true,
      ),
    );

    await _saveTasksService(_internalTasksListModel);

    emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
  }

  void _handlePendingTasksEvent(
    PendingTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    var state = await _loadTasksService();
    _internalTasksListModel = state.tasksListModel;

    _internalTasksListModel.tasksList.removeWhere(
      (e) => e.title == event.task.title,
    );

    _internalTasksListModel.tasksList.insert(
      event.index,
      TasksModel(
        title: event.task.title,
        date: event.task.date,
        isCompleted: false,
      ),
    );

    await _saveTasksService(_internalTasksListModel);

    emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
  }

  void _handleFilteringTasksEvent(
    FilteringTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    var state = await _loadTasksService();
    _internalTasksListModel = state.tasksListModel;

    if (event.selection.contains(Filter.completed)) {
      List<TasksModel> newList = _internalTasksListModel.tasksList
          .where((e) => e.isCompleted)
          .toList();

      _internalTasksListModel = _internalTasksListModel.copyWith(
        tasksList: newList,
      );

      emit(SuccessTasksState(
        _internalTasksListModel,
        <Filter>{Filter.completed},
      ));
    } else if (event.selection.contains(Filter.pending)) {
      List<TasksModel> newList = _internalTasksListModel.tasksList
          .where((e) => e.isCompleted == false)
          .toList();

      _internalTasksListModel = _internalTasksListModel.copyWith(
        tasksList: newList,
      );

      emit(SuccessTasksState(
        _internalTasksListModel,
        <Filter>{Filter.pending},
      ));
    } else {
      emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
    }
  }

  void _handleDeletingAllTasksEvent(
    DeletingAllTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    var state = await _loadTasksService();
    _internalTasksListModel = state.tasksListModel;

    _internalTasksListModel.tasksList.clear();

    await _deleteTasksService(_internalTasksListModel);

    emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
  }
}
