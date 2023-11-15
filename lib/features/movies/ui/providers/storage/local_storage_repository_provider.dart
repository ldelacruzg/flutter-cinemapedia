import 'package:flutter_cinemapedia/features/movies/infrastructure/datasources/isardb_local_storage_datasource.dart';
import 'package:flutter_cinemapedia/features/movies/infrastructure/repositories/local_storage_repository_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final localStorageRepositoryProvider = Provider(
  (ref) => LocalStorageRepositoryImpl(
    datasource: IsarDBLocalStorageDatasource(),
  ),
);
