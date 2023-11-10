import 'package:flutter_cinemapedia/features/movies/domain/entities/movie.dart';
import 'package:flutter_cinemapedia/features/movies/infrastructure/models/tmdb/tmdb_movie.dart';
import 'package:flutter_cinemapedia/features/movies/infrastructure/models/tmdb/tmdb_movie_details.dart';

class MovieMapper {
  static Movie fromTMDBMovie(TMDBMovieModel tmdbMovieModel) => Movie(
        adult: tmdbMovieModel.adult,
        backdropPath: tmdbMovieModel.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500${tmdbMovieModel.backdropPath}'
            : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
        genreIds: tmdbMovieModel.genreIds.map((e) => e.toString()).toList(),
        id: tmdbMovieModel.id,
        originalLanguage: tmdbMovieModel.originalLanguage,
        originalTitle: tmdbMovieModel.originalTitle,
        overview: tmdbMovieModel.overview,
        popularity: tmdbMovieModel.popularity,
        posterPath: tmdbMovieModel.posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500${tmdbMovieModel.posterPath}'
            : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
        releaseDate: tmdbMovieModel.releaseDate != null
            ? tmdbMovieModel.releaseDate!
            : DateTime.now(),
        title: tmdbMovieModel.title,
        video: tmdbMovieModel.video,
        voteAverage: tmdbMovieModel.voteAverage,
        voteCount: tmdbMovieModel.voteCount,
      );

  static Movie fromTMDBMovieDetails(
          TMDBMovieDetailsModel tmdbMovieDetailsModel) =>
      Movie(
        adult: tmdbMovieDetailsModel.adult,
        backdropPath: tmdbMovieDetailsModel.backdropPath != ''
            ? 'https://image.tmdb.org/t/p/w500${tmdbMovieDetailsModel.backdropPath}'
            : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
        genreIds: tmdbMovieDetailsModel.genres.map((e) => e.name).toList(),
        id: tmdbMovieDetailsModel.id,
        originalLanguage: tmdbMovieDetailsModel.originalLanguage,
        originalTitle: tmdbMovieDetailsModel.originalTitle,
        overview: tmdbMovieDetailsModel.overview,
        popularity: tmdbMovieDetailsModel.popularity,
        posterPath: tmdbMovieDetailsModel.posterPath != ''
            ? 'https://image.tmdb.org/t/p/w500${tmdbMovieDetailsModel.posterPath}'
            : 'https://static.displate.com/857x1200/displate/2022-04-15/7422bfe15b3ea7b5933dffd896e9c7f9_46003a1b7353dc7b5a02949bd074432a.jpg',
        releaseDate: tmdbMovieDetailsModel.releaseDate,
        title: tmdbMovieDetailsModel.title,
        video: tmdbMovieDetailsModel.video,
        voteAverage: tmdbMovieDetailsModel.voteAverage,
        voteCount: tmdbMovieDetailsModel.voteCount,
      );
}
