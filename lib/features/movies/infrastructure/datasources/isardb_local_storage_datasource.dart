import 'package:flutter_cinemapedia/features/movies/domain/entities/movie.dart';
import 'package:flutter_cinemapedia/features/movies/domain/datasources/local_storage_datasource.dart';

import 'package:path_provider/path_provider.dart'
    show getApplicationDocumentsDirectory;
import 'package:isar/isar.dart';

class IsarDBLocalStorageDatasource extends LocalStorageDatasource {
  late Future<Isar> db;

  IsarDBLocalStorageDatasource() {
    db = openDB();
  }

  Future<Isar> openDB() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      return await Isar.open(
        [MovieSchema],
        directory: dir.path,
        inspector: true,
      );
    }

    return Future.value(Isar.getInstance());
  }

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    final isar = await db;
    final movie = await isar.movies.filter().idEqualTo(movieId).findFirst();
    return movie != null;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isar = await db;

    final favMovie = await isar.movies.filter().idEqualTo(movie.id).findFirst();

    if (favMovie != null) {
      // remove from favorites
      isar.writeTxnSync(() => isar.movies.deleteSync(favMovie.isarId!));
      return;
    }

    // add to favorites
    isar.writeTxnSync(() => isar.movies.putSync(movie));
  }

  @override
  Future<List<Movie>> loadMovies({int limit = 10, offset = 0}) async {
    final isar = await db;
    final movies =
        await isar.movies.where().offset(offset).limit(limit).findAll();
    return movies;
  }
}
