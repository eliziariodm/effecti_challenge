import 'package:bloc_test/bloc_test.dart';
import 'package:effecti_challenge/app/modules/home/interactor/blocs/home_bloc.dart';
import 'package:effecti_challenge/app/modules/home/interactor/events/home_event.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/data_service.dart';
import 'package:effecti_challenge/app/modules/home/interactor/states/home_state.dart';
import 'package:effecti_challenge/app/utils/filter_enum.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DataServiceMock extends Mock implements DataService {}

void main() async {
  final dataServiceMock = DataServiceMock();
  final bloc = HomeBloc(dataServiceMock);

  final taskList = TasksListModel(
    tasksList: [
      TasksModel(title: 'task 1', date: '24/07/1992'),
      TasksModel(title: 'task 2', date: '26/07/1992'),
    ],
  );

  group('HomeBloc', () {
    when(() => dataServiceMock.readTasks()).thenAnswer(
      (_) async => taskList,
    );

    test(
        'should must return the initial state and the success state of the tasks',
        () async* {
      await expectLater(
        bloc,
        emitsInOrder(
          [isA<InitialTasksState>(), isA<SuccessTasksState>()],
        ),
      );
    });

    test('should return the initial state and error state of the tasks',
        () async* {
      await expectLater(
        bloc,
        emitsInOrder(
          [isA<InitialTasksState>(), isA<ErrorTasksState>()],
        ),
      );
    });

    blocTest<HomeBloc, HomeState>(
      'should return the loaded tasks',
      build: () => HomeBloc(dataServiceMock),
      act: (bloc) => bloc.add(LoadTasksEvent()),
      expect: () => [isA<SuccessTasksState>()],
    );

    blocTest<HomeBloc, HomeState>(
      'should return an added task',
      build: () => HomeBloc(dataServiceMock),
      act: (bloc) => bloc.add(AddingTasksEvent(
        'task 3',
        '26/07/1992',
      )),
      setUp: () {
        when(() => dataServiceMock.createUpdateTasks(taskList)).thenAnswer(
          (_) async => taskList,
        );
      },
      expect: () => [isA<SuccessTasksState>()],
    );

    blocTest<HomeBloc, HomeState>(
      'should return an edited task',
      build: () => HomeBloc(dataServiceMock),
      act: (bloc) => bloc.add(
        EditingTasksEvent(
          taskList.tasksList[0],
          0,
          'task 0',
          '26/07/1992',
        ),
      ),
      setUp: () {
        when(() => dataServiceMock.createUpdateTasks(taskList)).thenAnswer(
          (_) async => taskList,
        );
      },
      expect: () => [isA<SuccessTasksState>()],
    );

    blocTest<HomeBloc, HomeState>(
      'should return a completed task',
      build: () => HomeBloc(dataServiceMock),
      act: (bloc) => bloc.add(
        CompletingTasksEvent(taskList.tasksList[0], 0),
      ),
      setUp: () {
        when(() => dataServiceMock.createUpdateTasks(taskList)).thenAnswer(
          (_) async => taskList,
        );
      },
      expect: () => [isA<SuccessTasksState>()],
    );

    blocTest<HomeBloc, HomeState>(
      'should return a pending task',
      build: () => HomeBloc(dataServiceMock),
      act: (bloc) => bloc.add(
        PendingTasksEvent(taskList.tasksList[1], 1),
      ),
      setUp: () {
        when(() => dataServiceMock.createUpdateTasks(taskList)).thenAnswer(
          (_) async => taskList,
        );
      },
      expect: () => [isA<SuccessTasksState>()],
    );

    blocTest<HomeBloc, HomeState>(
      'should return a filtered task',
      build: () => HomeBloc(dataServiceMock),
      act: (bloc) => bloc.add(
        FilteringTasksEvent(
          taskList,
          <Filter>{Filter.completed},
        ),
      ),
      expect: () => [isA<SuccessTasksState>()],
    );

    blocTest<HomeBloc, HomeState>(
      'should delete the selected task',
      build: () => HomeBloc(dataServiceMock),
      act: (bloc) => bloc.add(
        DeletingTasksEvent(taskList.tasksList[1]),
      ),
      setUp: () {
        when(() => dataServiceMock.createUpdateTasks(taskList)).thenAnswer(
          (_) async => taskList,
        );
      },
      expect: () => [isA<SuccessTasksState>()],
    );

    blocTest<HomeBloc, HomeState>(
      'should delete all tasks',
      build: () => HomeBloc(dataServiceMock),
      act: (bloc) => bloc.add(DeletingAllTasksEvent()),
      setUp: () {
        when(() => dataServiceMock.deleteTasks(taskList)).thenAnswer(
          (_) async => taskList,
        );
      },
      expect: () => [isA<SuccessTasksState>()],
    );
  });
}
