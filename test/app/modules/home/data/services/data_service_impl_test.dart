import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_list_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/models/tasks_model.dart';
import 'package:effecti_challenge/app/modules/home/interactor/services/data_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class DataServiceMock extends Mock implements DataService {}

void main() {
  final dataServiceMock = DataServiceMock();
  final taskList = TasksListModel(
    tasksList: [
      TasksModel(title: 'task 1', date: '24/07/1992'),
      TasksModel(title: 'task 2', date: '26/07/1992'),
    ],
  );

  group('DataService', () {
    when(() => dataServiceMock.readTasks()).thenAnswer(
      (_) async => taskList,
    );

    test('should return a list of tasks', () {
      final result = dataServiceMock.readTasks();

      expect(result, completion(isA<TasksListModel>()));
    });

    when(() => dataServiceMock.createUpdateTasks(taskList)).thenAnswer(
      (_) async => taskList,
    );

    test('should return the creation or update of a task', () {
      final result = dataServiceMock.createUpdateTasks(taskList);

      expect(result, completion(isA<TasksListModel>()));
    });

    when(() => dataServiceMock.deleteTasks(taskList)).thenAnswer(
      (_) async => taskList,
    );

    test('should delete the tasks', () {
      final result = dataServiceMock.deleteTasks(taskList);

      expect(result, completion(isA<TasksListModel>()));
    });
  });
}
