import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/src/pages/posts/data/repository/posts_screen_repository.dart';
import 'package:tasks/src/pages/posts/presentation/controller/cubit/posts_screen_state.dart';

class TripsCubit extends Cubit<TripsState> {
  final TripRepository repo;
  TripsCubit(this.repo) : super(TripsInitial());

  void fetchTrips() async {
    emit(TripsLoading());
    try {
      final trips = await repo.loadTrips();
      emit(TripsLoaded(trips));
    } catch (e) {
      emit(TripsError(e.toString()));
    }
  }
}
