import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MovieDatasource {
  Future<List<Movie>> getNowPlaging({int page = 1});
}
