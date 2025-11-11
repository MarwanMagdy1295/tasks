import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasks/src/pages/posts/presentation/components/trip_card.dart';
import 'package:tasks/src/pages/posts/presentation/controller/cubit/posts_screen_cubit.dart';
import 'package:tasks/src/pages/posts/presentation/controller/cubit/posts_screen_state.dart';

class HomeContent extends StatelessWidget {
  final TripsState state;
  const HomeContent({Key? key, required this.state}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (state is TripsLoading) {
      return const Center(child: CircularProgressIndicator());
    } else if (state is TripsLoaded) {
      final trips = (state as TripsLoaded).trips;
      return LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 1000;
          final crossAxis = isWide ? 3 : (constraints.maxWidth > 600 ? 2 : 1);
          return GridView.count(
            crossAxisCount: crossAxis,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            children: trips.map((t) => TripCard(trip: t)).toList(),
          );
        },
      );
    } else if (state is TripsError) {
      return Center(child: Text('Error: ${(state as TripsError).message}'));
    }
    return const SizedBox.shrink();
  }
}
