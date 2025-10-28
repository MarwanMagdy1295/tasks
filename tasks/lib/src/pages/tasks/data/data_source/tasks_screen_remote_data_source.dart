import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:tasks/src/models/task_model.dart';

abstract class TasksScreenRemoteDataSourceInterface {
  Future<List<TaskModel>?> getTasks({String? status});
  Future<void> deleteAllTasks();
}

class TasksScreenRemoteDataSource extends TasksScreenRemoteDataSourceInterface {
  TasksScreenRemoteDataSource();

  @override
  Future<List<TaskModel>?> getTasks({String? status}) async {
    try {
      var taskBox = Hive.box<TaskModel>('tasksBox');
      if (kDebugMode) {
        print(taskBox.values.toList());
      }
      List<TaskModel> tasks = taskBox.values.toList();
      switch (status) {
        case 'new':
          return tasks.where((task) => task.status == 'new').toList();
        case 'pending':
          return tasks.where((task) => task.status == 'pending').toList();
        case 'done':
          return tasks.where((task) => task.status == 'done').toList();
        default:
          return tasks;
      }
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Future<void> deleteAllTasks() async {
    try {
      var taskBox = Hive.box<TaskModel>('tasksBox');
      await taskBox.clear();
    } catch (e) {
      throw e.toString();
    }
  }
}
