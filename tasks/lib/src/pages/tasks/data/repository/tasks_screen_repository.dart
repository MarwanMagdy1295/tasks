import 'package:tasks/src/models/task_model.dart';
import 'package:tasks/src/pages/tasks/data/data_source/tasks_screen_remote_data_source.dart';

abstract class TasksScreenRepositoryInterface {
  Future<List<TaskModel>?> getTasks({String? status});
  Future<void> deleteAllTasks();
}

class TasksScreenRepository extends TasksScreenRepositoryInterface {
  final TasksScreenRemoteDataSource _tasksScreenRemoteDataSource;

  TasksScreenRepository({
    required TasksScreenRemoteDataSource requestsScreenRemoteDataSource,
  }) : _tasksScreenRemoteDataSource = requestsScreenRemoteDataSource;
  @override
  Future<List<TaskModel>?> getTasks({String? status}) {
    return _tasksScreenRemoteDataSource.getTasks(status: status);
  }

  @override
  Future<void> deleteAllTasks() {
    return _tasksScreenRemoteDataSource.deleteAllTasks();
  }
}
