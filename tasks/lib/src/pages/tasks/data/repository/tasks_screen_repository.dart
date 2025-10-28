import 'package:tasks/src/models/task_model.dart';
import 'package:tasks/src/pages/tasks/data/data_source/tasks_screen_remote_data_source.dart';

abstract class TasksScreenRepositoryInterface {
  Future<List<TaskModel>?> getTasks({
    String? status,
    required int pageSize,
    required int currentPage,
    required List<TaskModel> oldTasks,
  });
  Future<void> deleteAllTasks();
}

class TasksScreenRepository extends TasksScreenRepositoryInterface {
  final TasksScreenRemoteDataSource _tasksScreenRemoteDataSource;

  TasksScreenRepository({
    required TasksScreenRemoteDataSource requestsScreenRemoteDataSource,
  }) : _tasksScreenRemoteDataSource = requestsScreenRemoteDataSource;
  @override
  Future<List<TaskModel>?> getTasks({
    String? status,
    required int pageSize,
    required int currentPage,
    required List<TaskModel> oldTasks,
  }) {
    return _tasksScreenRemoteDataSource.getTasks(
      status: status,
      pageSize: pageSize,
      currentPage: currentPage,
      oldTasks: oldTasks,
    );
  }

  @override
  Future<void> deleteAllTasks() {
    return _tasksScreenRemoteDataSource.deleteAllTasks();
  }
}
