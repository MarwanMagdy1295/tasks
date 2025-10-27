// ignore_for_file: unused_field

import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:tasks/src/core/services/hive_service.dart';
import 'package:tasks/src/models/task_model.dart';

abstract class AddTaskScreenRemoteDataSourceInterface {
  Future<void> addTask({required TaskModel task});
}

class AddTaskScreenRemoteDataSource
    extends AddTaskScreenRemoteDataSourceInterface {
  final HiveService _hiveService;

  AddTaskScreenRemoteDataSource({required HiveService hiveService})
    : _hiveService = hiveService;

  @override
  Future<void> addTask({required TaskModel task}) async {
    try {
      var taskBox = Hive.box<TaskModel>('tasksBox');
      await taskBox.add(task);
    } catch (e) {
      // throw ErrorModel.parse(e);
      throw e.toString();
    }
  }
}
