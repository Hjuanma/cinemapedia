import 'package:cinemapedia/domain/entities/movie.dart';

abstract class MoviesRepository {
  Future<List<Movie>> getNowPlaging({int page = 1});
  Future<List<Movie>> getPopularMovies({int page = 1});
  Future<List<Movie>> getTopRatedMovies({int page = 1});
  Future<List<Movie>> getUpcomingMovies({int page = 1});

  Future<Movie> getMovieById(String id);
  Future<List<Movie>> searcheMovies(String query);

  Future<List<Movie>> getSimilarMovies(int movieId);

  Future<List<String>> getYoutubeVideosById(int movieId);
}
