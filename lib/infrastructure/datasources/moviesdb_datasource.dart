import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_details.dart';
import 'package:dio/dio.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_respose.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import '../../config/constants/constants.dart';
import '../../domain/datasources/movies_datasource.dart';
import '../mappers/moviedb/movie_mapper.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(baseUrl: TheMoviesDB.baseUrl, queryParameters: {
    "api_key": Environment.theMovieDbKey,
    "language": AppConstants.language
  }));

  List<Movie> _jsonToMovie(Map<String, dynamic> json) {
    final movieDBResponse = MovieDbResponse.fromJson(json);

    final List<Movie> movies = movieDBResponse.results
        .where((movieDb) => movieDb.posterPath != "no-poster")
        .map((movieDb) => MovieMapper.movieDBToEntity(movieDb))
        .toList();
    return movies;
  }

  @override
  Future<List<Movie>> getNowPlaging({int page = 1}) async {
    final response = await dio.get(
        "${TheMoviesDB.movie}${TheMoviesDB.nowPlaying}",
        queryParameters: {"page": page});

    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getPopularMovies({int page = 1}) async {
    final response = await dio.get("${TheMoviesDB.movie}${TheMoviesDB.popular}",
        queryParameters: {"page": page});

    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getTopRatedMovies({int page = 1}) async {
    final response = await dio.get(
        "${TheMoviesDB.movie}${TheMoviesDB.topRated}",
        queryParameters: {"page": page});

    return _jsonToMovie(response.data);
  }

  @override
  Future<List<Movie>> getUpcomingMovies({int page = 1}) async {
    final response = await dio.get(
        "${TheMoviesDB.movie}${TheMoviesDB.upcoming}",
        queryParameters: {"page": page});

    return _jsonToMovie(response.data);
  }

  @override
  Future<Movie> getMovieById(String id) async {
    final response = await dio.get("${TheMoviesDB.movie}$id");

    if (response.statusCode != 200)
      throw Exception("Movie with id: $id not found");

    final movieDB = MovieDbDetails.fromJson(response.data);

    final movie = MovieMapper.movieDbDetailsToEntity(movieDB);

    return movie;
  }
  
  @override
  Future<List<Movie>> searcheMovies(String query) async{
       final response = await dio.get(
        "${TheMoviesDB.search}movie",
        queryParameters: {"query": query});

    return _jsonToMovie(response.data);
  }
}
