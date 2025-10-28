import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tasks/src/core/base_cubit/base_cubit.dart';
import 'package:tasks/src/models/task_model.dart';
import 'package:tasks/src/pages/create_task/data/repository/add_task_screen_repository.dart';
import 'package:tasks/src/pages/create_task/presentation/controller/cubit/create_task_screen_state.dart';

class CreateTaskScreenCubit extends BaseCubit<CreateTaskScreenState>
    with
        AdaptiveCubit<CreateTaskScreenState>,
        ResetLazySingleton<CreateTaskScreenCubit, CreateTaskScreenState> {
  final AddTaskScreenRepository _addTaskScreenRepository;
  CreateTaskScreenCubit({
    required AddTaskScreenRepository addTaskScreenRepository,
  }) : _addTaskScreenRepository = addTaskScreenRepository,
       super(CreateTaskScreenInitial());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  String? date;
  TaskModel newTask = TaskModel();
  String? selectedState;

  setData(TaskModel task) {
    if (task.taskTitle != null) {
      titleController.text = task.taskTitle ?? '';
      dateController.text = task.createdAt ?? '';
      date = task.createdAt ?? '';
      selectedState = task.status;
    }
  }

  Future<void> addOrEditNewTask(bool isEdit, TaskModel task) async {
    if (formKey.currentState!.validate()) {
      emit(CreateTaskScreenLoadingState());
      if (isEdit) {
        task.taskTitle = titleController.text;
        task.createdAt = date ?? DateTime.now().toString();
        task.status = selectedState;
        task.save();
        emit(CreateTaskScreenSuccessState());
      } else {
        newTask.taskTitle = titleController.text;
        newTask.createdAt = date ?? DateFormat('y-M-d').format(DateTime.now());
        newTask.status = 'new';
        await _addTaskScreenRepository
            .addTask(task: newTask)
            .then((value) {
              emit(CreateTaskScreenSuccessState());
            })
            .catchError((onError) {
              emit(CreateTaskScreenFailedState(onError));
            });
      }
    }
  }
}
