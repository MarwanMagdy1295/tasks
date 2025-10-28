class TasksScreenState {}

final class TasksScreenInitial extends TasksScreenState {}

final class TasksScreenLoading extends TasksScreenState {}

final class TasksScreenDeleteTaskLoading extends TasksScreenState {}

final class TasksScreenDeleteTaskScrollLoading extends TasksScreenState {}

final class TasksScreenSuccess extends TasksScreenState {}

final class TasksScreenFailed extends TasksScreenState {
  String errorMessage;
  TasksScreenFailed(this.errorMessage);
}
