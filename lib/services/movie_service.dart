import 'package:movie_app/const.dart';
import 'package:movie_app/models/main_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:tmdb_api/tmdb_api.dart';

class MovieService {
  static final tmdb = TMDB(
    ApiKeys(apiKey, 'apiReadAccessTokenv4'),
  );

  Future<Set<Movie>> search(String title, MainModel mainModel) async {
    Set<Movie> foundMovies = {};
    try {
      Map response = await tmdb.v3.search.queryMovies(title);
      for (var x = 0; x < response['results'].length; x++) {
        foundMovies.add(Movie.fromJson(response['results'][x]));
      }
      for (Movie movie in mainModel.hiddenMovies) {
        foundMovies.removeWhere((element) => element.id == movie.id);
      }
      for (Movie movie in mainModel.favouriteMovies) {
        foundMovies.removeWhere((element) => element.id == movie.id);
      }
      return foundMovies;
    } catch (e) {
      return {};
    }
  }
}
