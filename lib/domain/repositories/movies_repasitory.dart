import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> getNowPlaging({int page = 1});
}
