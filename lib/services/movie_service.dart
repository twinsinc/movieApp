import 'package:movie_app/const.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MovieService {
  static final tmdb = TMDB(
    ApiKeys(apiKey, 'apiReadAccessTokenv4'),
  );

  static Future<List<Movie>> getPopularMovies() async {
    List<Movie> movies = [];
    Map response = await tmdb.v3.movies.getTopRated();
    for (var x = 0; x < response['results'].length; x++) {
      movies.add(Movie.fromJson(response['results'][x]));
    }
    print(movies);
    return movies;
  }

  static search(String name) async {
    return tmdb.v3.search.queryMovies(name);
  }
}
