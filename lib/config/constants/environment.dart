import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String theMovieDbApiKey =
      dotenv.env['TMDB_API_KEY'] ?? 'No hay API KEY';
}
