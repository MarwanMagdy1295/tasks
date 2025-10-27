class CreateTaskScreenState {}

final class CreateTaskScreenInitial extends CreateTaskScreenState {}

final class CreateTaskScreenLoadingState extends CreateTaskScreenState {}

final class CreateTaskScreenSuccessState extends CreateTaskScreenState {}

final class CreateTaskScreenFailedState extends CreateTaskScreenState {
  String errorMessage;
  CreateTaskScreenFailedState(this.errorMessage);
}
