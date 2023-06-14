import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/moviedb_details.dart';
import '../../config/constants/themoviesdb.dart';
import '../models/moviedb/movie_moviedb.dart';

class MovieMapper {
  static Movie movieDBToEntity(MovieMovieDb movieDb) => Movie(
      adult: movieDb.adult,
      backdropPath: (movieDb.backdropPath != '')
          ? '${TheMoviesDB.baseImageUrl}${movieDb.backdropPath}'
          : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      genreIds: movieDb.genreIds.map((e) => e.toString()).toList(),
      id: movieDb.id,
      originalLanguage: movieDb.originalLanguage,
      originalTitle: movieDb.originalTitle,
      overview: movieDb.overview,
      popularity: movieDb.popularity,
      posterPath: (movieDb.posterPath != '')
          ? '${TheMoviesDB.baseImageUrl}${movieDb.posterPath}'
          : 'no-poster',
      releaseDate: movieDb.releaseDate,
      title: movieDb.title,
      video: movieDb.video,
      voteAverage: movieDb.voteAverage,
      voteCount: movieDb.voteCount);

  static Movie movieDbDetailsToEntity(MovieDbDetails movieDbDetails) => Movie(
      adult: movieDbDetails.adult,
      backdropPath: (movieDbDetails.backdropPath != '')
          ? '${TheMoviesDB.baseImageUrl}${movieDbDetails.backdropPath}'
          : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      genreIds: movieDbDetails.genres.map((e) => e.toString()).toList(),
      id: movieDbDetails.id,
      originalLanguage: movieDbDetails.originalLanguage,
      originalTitle: movieDbDetails.originalTitle,
      overview: movieDbDetails.overview,
      popularity: movieDbDetails.popularity,
      posterPath: (movieDbDetails.posterPath != '')
          ? '${TheMoviesDB.baseImageUrl}${movieDbDetails.posterPath}'
          : 'https://sd.keepcalms.com/i-w600/keep-calm-poster-not-found.jpg',
      releaseDate: movieDbDetails.releaseDate,
      title: movieDbDetails.title,
      video: movieDbDetails.video,
      voteAverage: movieDbDetails.voteAverage,
      voteCount: movieDbDetails.voteCount);
}
