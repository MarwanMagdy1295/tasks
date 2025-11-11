import 'dart:convert';

import 'package:tasks/src/models/trip_model.dart';
import 'package:flutter/services.dart';

abstract class PostsScreenRemoteDataSourceInterface {
  Future<List<Trip>?> getPosts();
}

class PostsScreenRemoteDataSource extends PostsScreenRemoteDataSourceInterface {
  PostsScreenRemoteDataSource();

  @override
  Future<List<Trip>?> getPosts() async {
    try {
      final data = await rootBundle.loadString('assets/data/trips_mock.json');
      final decoded = json.decode(data);
      return (decoded['trips'] as List).map((e) => Trip.fromJson(e)).toList();
    } catch (e) {
      throw e.toString();
    }
  }
}
