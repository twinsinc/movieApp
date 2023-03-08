import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/store_service.dart';

class MainModel extends ChangeNotifier {
  static late final List<Movie> _favouriteMovies;
  get favouriteMovies => _favouriteMovies;
  static late final List<Movie> _hiddenMovies;
  get hiddenMovies => _hiddenMovies;

  static void init() {
    String? storedFavouriteMovies = StorageService.getFavouriteMovies();
    String? storedHiddenMovies = StorageService.getHiddenMovies();
    storedFavouriteMovies == null
        ? _favouriteMovies = []
        : _favouriteMovies = Movie.decode(storedFavouriteMovies);
    storedHiddenMovies == null
        ? _hiddenMovies = []
        : _hiddenMovies = Movie.decode(storedHiddenMovies);
  }

  void addFavouriteMovie(Movie movie) {
    movie.favourite = true;
    _favouriteMovies.add(movie);
    StorageService.setFavouriteMovies(Movie.encode(_favouriteMovies));
    notifyListeners();
  }

  void hideMovie(Movie movie) {
    _hiddenMovies.add(movie);
    StorageService.setHiddenMovies(Movie.encode(_hiddenMovies));
    notifyListeners();
  }

  void removeMovie(Movie movie) {
    _favouriteMovies.remove(movie);
    movie.favourite = false;
    StorageService.setFavouriteMovies(Movie.encode(_favouriteMovies));
    notifyListeners();
  }
}
