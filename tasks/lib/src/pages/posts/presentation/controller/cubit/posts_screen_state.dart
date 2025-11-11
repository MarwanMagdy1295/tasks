import 'package:tasks/src/models/trip_model.dart';

abstract class TripsState {}

class TripsInitial extends TripsState {}

class TripsLoading extends TripsState {}

class TripsLoaded extends TripsState {
  final List<Trip> trips;
  TripsLoaded(this.trips);
}

class TripsError extends TripsState {
  final String message;
  TripsError(this.message);
}
