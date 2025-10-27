import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/core/base_cubit/base_cubit.dart';
import 'package:tasks/src/core/utils/assets/translations/keys.dart';
import 'package:tasks/src/models/task_model.dart';
import 'package:tasks/src/pages/tasks/data/repository/tasks_screen_repository.dart';
import 'package:tasks/src/pages/tasks/presentation/controller/cubit/tasks_screen_state.dart';

class TasksScreenCubit extends BaseCubit<TasksScreenState>
    with
        AdaptiveCubit<TasksScreenState>,
        ResetLazySingleton<TasksScreenCubit, TasksScreenState> {
  final TasksScreenRepository _tasksScreenRepository;
  TasksScreenCubit({required TasksScreenRepository tasksScreenRepository})
    : _tasksScreenRepository = tasksScreenRepository,
      super(TasksScreenInitial());

  TextEditingController searchController = TextEditingController();
  List<Map<String, bool>> taskStatus = [
    {tasks_screen.all.tr(): true},
    {tasks_screen.new_task.tr(): false},
    {tasks_screen.pending.tr(): false},
    {tasks_screen.done.tr(): false},
  ];

  List<TaskModel> tasks = [];
  List<TaskModel> backupTasks = [];
  String selectedFilter = TaskFilter.all.value;

  getTasks() async {
    emit(TasksScreenLoading());
    await _tasksScreenRepository
        .getTasks(status: selectedFilter)
        .then((value) {
          Timer(const Duration(seconds: 2), () {
            if (kDebugMode) {
              print('⏰ Timer to give a chance to loading state to appear 😁');
            }
            tasks = value?.reversed.toList() ?? [];
            backupTasks = value?.reversed.toList() ?? [];
            emit(TasksScreenSuccess());
          });
        })
        .catchError((onError) {
          emit(TasksScreenFailed(onError));
        });
  }

  void searchFilesByAnyChar() {
    if (searchController.text.isEmpty) {
      tasks = backupTasks;
      emit(TasksScreenSuccess());
    } else if (backupTasks.isEmpty) {
      return;
    } else {
      emit(TasksScreenLoading());
      final chars = searchController.text.toLowerCase().split('');
      tasks = backupTasks.where((file) {
        if (file.taskTitle == null) return false;
        final name = file.taskTitle!.toLowerCase();
        return chars.any((c) => name.contains(c));
      }).toList();
      emit(TasksScreenSuccess());
    }
  }

  selectFilter(Map<String, bool> filter) {
    for (var map in taskStatus) {
      if (map.keys.first == filter.keys.first) {
        map.update(filter.keys.first, (value) => true);
      } else {
        map.update(map.keys.first, (value) => false);
      }
    }
    selectedFilter = filter.keys.first;
    if (kDebugMode) {
      print(selectedFilter);
    }
    searchController.clear();
    getTasks();
  }

  deleteTask(TaskModel task) {
    emit(TasksScreenLoading());
    Timer(const Duration(seconds: 1), () {
      task.delete();
      getTasks();
    });
  }

  deleteAllTasks() {
    if (tasks.isNotEmpty) {
      emit(TasksScreenLoading());
      Timer(const Duration(seconds: 1), () {
        _tasksScreenRepository
            .deleteAllTasks()
            .then((onValue) {
              tasks.clear();
              backupTasks.clear();
              emit(TasksScreenSuccess());
            })
            .catchError((onError) {
              emit(TasksScreenFailed(onError));
            });
      });
    }
  }
}

enum TaskFilter {
  all('All'),
  newTask('New'),
  pending('Pending'),
  done('Done');

  final String value;
  const TaskFilter(this.value);
}
