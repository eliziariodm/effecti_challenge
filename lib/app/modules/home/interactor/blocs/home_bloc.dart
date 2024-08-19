import 'package:effecti_challenge/app/modules/home/interactor/events/home_event.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/data_service.dart';
import 'package:effecti_challenge/app/modules/home/interactor/states/home_state.dart';
import 'package:effecti_challenge/app/utils/filter_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DataService _dataService;

  HomeBloc(
    this._dataService,
  ) : super(InitialTasksState()) {
    on<LoadTasksEvent>(_handleLoadTasks);
    on<AddingTasksEvent>(_handleAddingTasksEvent);
    on<EditingTasksEvent>(_handleEditingTasksEvent);
    on<DeletingTasksEvent>(_handleDeletingTasksEvent);
    on<CompletingTasksEvent>(_handleCompletingTasksEvent);
    on<PendingTasksEvent>(_handlePendingTasksEvent);
    on<FilteringTasksEvent>(_handleFilteringTasksEvent);
    on<DeletingAllTasksEvent>(_handleDeletingAllTasksEvent);
    on<DueDateTasksEvent>(_handleDueDateTasksEvent);
  }

  TasksListModel _internalTasksListModel = TasksListModel.empty();

  void _handleLoadTasks(
    LoadTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    _internalTasksListModel = await _dataService.readTasks();

    emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
  }

  void _handleAddingTasksEvent(
    AddingTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    _internalTasksListModel = await _dataService.readTasks();

    if (_internalTasksListModel.tasksList
        .any((item) => item.title == event.title)) {
      emit(ErrorTasksState());
    } else {
      _internalTasksListModel.tasksList.add(
        TasksModel(
          title: event.title,
          date: event.date,
        ),
      );
    }

    await _dataService.createUpdateTasks(_internalTasksListModel);

    emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
  }

  void _handleEditingTasksEvent(
    EditingTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    _internalTasksListModel = await _dataService.readTasks();

    if (_internalTasksListModel.tasksList
        .any((item) => item.title == event.title)) {
      emit(ErrorTasksState());
    } else {
      _internalTasksListModel.tasksList.removeWhere(
        (e) => e.title == event.task.title,
      );

      _internalTasksListModel.tasksList.insert(
        event.index,
        TasksModel(
          title: event.title,
          date: event.date,
          isCompleted: event.task.isCompleted,
          isExpired: event.task.isExpired,
        ),
      );
    }

    await _dataService.createUpdateTasks(_internalTasksListModel);

    emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
  }

  void _handleDeletingTasksEvent(
    DeletingTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    _internalTasksListModel = await _dataService.readTasks();

    _internalTasksListModel.tasksList.removeWhere(
      (e) => e.title == event.task.title,
    );

    await _dataService.createUpdateTasks(_internalTasksListModel);

    emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
  }

  void _handleCompletingTasksEvent(
    CompletingTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    _internalTasksListModel = await _dataService.readTasks();

    _internalTasksListModel.tasksList.removeWhere(
      (e) => e.title == event.task.title,
    );

    _internalTasksListModel.tasksList.insert(
      event.index,
      TasksModel(
        title: event.task.title,
        date: event.task.date,
        isCompleted: true,
        isExpired: event.task.isExpired,
      ),
    );

    await _dataService.createUpdateTasks(_internalTasksListModel);

    emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
  }

  void _handlePendingTasksEvent(
    PendingTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    _internalTasksListModel = await _dataService.readTasks();

    _internalTasksListModel.tasksList.removeWhere(
      (e) => e.title == event.task.title,
    );

    _internalTasksListModel.tasksList.insert(
      event.index,
      TasksModel(
        title: event.task.title,
        date: event.task.date,
        isCompleted: false,
        isExpired: event.task.isExpired,
      ),
    );

    await _dataService.createUpdateTasks(_internalTasksListModel);

    emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
  }

  void _handleFilteringTasksEvent(
    FilteringTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    _internalTasksListModel = await _dataService.readTasks();

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
    _internalTasksListModel = await _dataService.readTasks();

    _internalTasksListModel.tasksList.clear();

    await _dataService.deleteTasks(_internalTasksListModel);

    emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
  }

  void _handleDueDateTasksEvent(
    DueDateTasksEvent event,
    Emitter<HomeState> emit,
  ) async {
    _internalTasksListModel = await _dataService.readTasks();

    for (var item in _internalTasksListModel.tasksList) {
      if (item.date.isNotEmpty) {
        var index = _internalTasksListModel.tasksList.indexOf(item);
        var dueDate = DateFormat('dd/MM/yyyy').parse(item.date);

        DateTime now = DateTime.now();
        DateTime dateTimeNow = DateTime(now.year, now.month, now.day);

        if (dateTimeNow.isAfter(dueDate)) {
          _internalTasksListModel.tasksList.removeWhere(
            (e) => e.title == item.title,
          );

          _internalTasksListModel.tasksList.insert(
            index,
            TasksModel(
              title: item.title,
              date: item.date,
              isCompleted: item.isCompleted,
              isExpired: true,
            ),
          );
          await _dataService.createUpdateTasks(_internalTasksListModel);

          emit(DueDateTasksState(
            _internalTasksListModel,
            <Filter>{Filter.all},
          ));
        }
      } else {
        emit(SuccessTasksState(_internalTasksListModel, <Filter>{Filter.all}));
      }
    }
  }
}
