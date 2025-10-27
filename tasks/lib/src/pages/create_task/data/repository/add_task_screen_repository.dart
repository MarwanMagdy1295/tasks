import 'package:tasks/src/models/task_model.dart';
import 'package:tasks/src/pages/create_task/data/data_source/add_task_screen_remote_data_source.dart';

abstract class AddTaskScreenRepositoryInterface {
  Future<void> addTask({required TaskModel task});
}

class AddTaskScreenRepository extends AddTaskScreenRepositoryInterface {
  final AddTaskScreenRemoteDataSource _addTaskScreenRemoteDataSource;

  AddTaskScreenRepository({
    required AddTaskScreenRemoteDataSource addTaskScreenRemoteDataSource,
  }) : _addTaskScreenRemoteDataSource = addTaskScreenRemoteDataSource;
  @override
  Future<void> addTask({required TaskModel task}) {
    return _addTaskScreenRemoteDataSource.addTask(task: task);
  }
}
