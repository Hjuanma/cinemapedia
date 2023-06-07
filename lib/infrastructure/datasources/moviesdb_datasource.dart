import 'package:dio/dio.dart';
import 'package:cinemapedia/infrastructure/mappers/movie_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_respose.dart';
import 'package:cinemapedia/config/constants/environment.dart';
import 'package:cinemapedia/config/constants/themoviesdb.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import '../../domain/datasources/movies_datasource.dart';

class MoviedbDatasource extends MoviesDatasource {
  final dio = Dio(BaseOptions(baseUrl: TheMoviesDB.baseUrl, queryParameters: {
    "api_key": Environment.theMovieDbKey,
    "language": "es-MX"
  }));

  @override
  Future<List<Movie>> getNowPlaging({int page = 1}) async {
    final response =
        await dio.get("${TheMoviesDB.movie}${TheMoviesDB.nowPlaying}");

    final movieDBResponse = MovieDbResponse.fromJson(response.data);

    final List<Movie> movies = movieDBResponse.results
    .where((movieDb) => movieDb.posterPath != "no-poster")
        .map((movieDb) => MovieMapper.movieDBToEntity(movieDb))
        .toList();
    return movies;
  }
}
