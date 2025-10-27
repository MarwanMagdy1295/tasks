import 'package:get_it/get_it.dart';
import 'package:tasks/src/core/services/hive_service.dart';
import 'package:tasks/src/pages/create_task/data/data_source/add_task_screen_remote_data_source.dart';
import 'package:tasks/src/pages/create_task/data/repository/add_task_screen_repository.dart';
import 'package:tasks/src/pages/create_task/presentation/controller/cubit/create_task_screen_cubit.dart';
import 'package:tasks/src/pages/tasks/data/data_source/tasks_screen_remote_data_source.dart';
import 'package:tasks/src/pages/tasks/data/repository/tasks_screen_repository.dart';
import 'package:tasks/src/pages/tasks/presentation/controller/cubit/tasks_screen_cubit.dart';

final di = GetIt.instance;

class DiService {
  static init() async {
    // NetworkService
    // di.registerLazySingleton(() => NetworkService(prefsService: di()));

    // PrefsService
    // di.registerLazySingleton(() => PrefsService());
    // await di<PrefsService>().init();

    // HiveService
    di.registerLazySingleton(() => HiveService());
    await di<HiveService>().init();

    // TasksScreen
    di.registerLazySingleton(() => TasksScreenRemoteDataSource());
    di.registerLazySingleton(
      () => TasksScreenRepository(requestsScreenRemoteDataSource: di()),
    );
    di.registerLazySingleton(
      () => TasksScreenCubit(tasksScreenRepository: di()),
    );
    // CreateTasksScreen
    di.registerLazySingleton(
      () => AddTaskScreenRemoteDataSource(hiveService: di()),
    );
    di.registerLazySingleton(
      () => AddTaskScreenRepository(addTaskScreenRemoteDataSource: di()),
    );
    di.registerLazySingleton(
      () => CreateTaskScreenCubit(addTaskScreenRepository: di()),
    );
  }
}
