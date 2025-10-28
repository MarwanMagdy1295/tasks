import 'package:flutter/foundation.dart';
import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:tasks/src/models/task_model.dart';

abstract class TasksScreenRemoteDataSourceInterface {
  Future<List<TaskModel>?> getTasks({
    String? status,
    required int pageSize,
    required int currentPage,
    required List<TaskModel> oldTasks,
  });
  Future<void> deleteAllTasks();
}

class TasksScreenRemoteDataSource extends TasksScreenRemoteDataSourceInterface {
  TasksScreenRemoteDataSource();

  @override
  Future<List<TaskModel>?> getTasks({
    String? status,
    required int pageSize,
    required int currentPage,
    required List<TaskModel> oldTasks,
  }) async {
    try {
      var taskBox = Hive.box<TaskModel>('tasksBox');
      List<TaskModel> tasks = [];
      final total = taskBox.length;
      final start = currentPage * pageSize;
      // final end = (start + pageSize < total) ? start + pageSize : total;
      if (start < total) {
        final newItems = taskBox.values.skip(start).take(pageSize).toList();
        tasks = oldTasks;
        tasks.addAll(newItems);
      } else {
        tasks = oldTasks;
      }
      switch (status) {
        case 'new':
          return tasks.where((task) => task.status == 'new').toList();
        case 'pending':
          return tasks.where((task) => task.status == 'pending').toList();
        case 'done':
          return tasks.where((task) => task.status == 'done').toList();
        default:
          if (kDebugMode) {
            print(tasks.toList());
          }
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
