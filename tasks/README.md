# tasks

A new Flutter project.

## Getting Started

📱 Features
✅ Task Management
Create, read,edit and delete tasks
Mark tasks as new or pending or done
Filter tasks by status (All, New, Pending, Done)
Delete all tasks at once
✅ Offline Support
Stores data locally using Hive (no internet required)
✅ Pagination
Efficiently loads large lists of tasks in pages
✅ Localization
Supports multiple languages (e.g. English, Arabic)
✅ UI
Responsive, clean architecture(presentation / domain / data layers).

Flutter version 3.35.5
Dart version 3.9.2
DevTools version 2.48.0
Platform android-36

lib/
 ├── main.dart
 ├── src
    └── app
    └── core
        └── services/
            └── hive_service.dart
            └── utils/
                └── keys.dart
                └── assets.gen.dart
 │    └── models/
        └── task_model.dart
      └── pages/
            └── create_tasks_screen
                └── data
                    └── data_source
                        └── add_task_screen_remote_data_source.dart
                └── repository
                    └── add_task_screen_repository.dart
                └── presentation
                        └── controller
                            └── cubit
                                └── create_task_screen_cubit.dart
                                └── create_task_screen_state.dart
                        └── ui
                           └── create_task.dart
            └── tasks_screen
                └── data
                    └── data_source
                        └── tasks_screen_remote_data_source.dart
                └── repository
                    └── tasks_screen_repository.dart
                 └── presentation
                        └── components
                           └── task_card.dart
                        └── controller
                           └── cubit
                                └── tasks_screen_cubit.dart
                                └── tasks_screen_state.dart
                        └── ui
                           └── tasks.dart


## Note =>> i make timer when get data to present loading state and loading state component