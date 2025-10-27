import 'package:hive_ce_flutter/hive_flutter.dart';
import 'package:tasks/src/models/task_model.dart';

class HiveService {
  Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(TaskModelAdapter());
    await Hive.openBox<TaskModel>('tasksBox');
  }
}
