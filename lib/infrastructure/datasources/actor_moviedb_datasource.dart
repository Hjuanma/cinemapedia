import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';

import '../../config/constants/constants.dart';
import '../../domain/entities/entities.dart';
import '../mappers/moviedb/actor_mapper.dart';

class ActorMovieDbDatasource extends ActorsDatasource {
  final dio = Dio(BaseOptions(baseUrl: TheMoviesDB.baseUrl, queryParameters: {
    "api_key": Environment.theMovieDbKey,
    "language": AppConstants.language
  }));
  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    final response =
        await dio.get("${TheMoviesDB.movie}$movieId/${TheMoviesDB.credits}");

    return _jsonToMovie(response.data);
  }

  List<Actor> _jsonToMovie(Map<String, dynamic> json) {
    final castResponse = CreditsResponse.fromJson(json);

    final List<Actor> actors = castResponse.cast
        .map((actor) => ActorMapper.castToEntity(actor))
        .toList();
    return actors;
  }
}
