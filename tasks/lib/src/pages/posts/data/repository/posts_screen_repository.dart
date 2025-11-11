import 'package:tasks/src/models/trip_model.dart';
import 'package:tasks/src/pages/posts/data/data_source/posts_screen_remote_data_source.dart';

abstract class PostsScreenRepositoryInterface {
  Future<List<Trip>?> getPosts();
}

class PostsScreenRepository extends PostsScreenRepositoryInterface {
  final PostsScreenRemoteDataSource _tasksScreenRemoteDataSource;

  PostsScreenRepository({
    required PostsScreenRemoteDataSource requestsScreenRemoteDataSource,
  }) : _tasksScreenRemoteDataSource = requestsScreenRemoteDataSource;
  @override
  Future<List<Trip>?> getPosts() {
    return _tasksScreenRemoteDataSource.getPosts();
  }
}

// class TripRepository {
//   Future<List<Trip>> loadTrips() async {
//     final data = await rootBundle.loadString('assets/data/trips_mock.json');
//     final decoded = json.decode(data);
//     return (decoded['trips'] as List).map((e) => Trip.fromJson(e)).toList();
//   }
// }
