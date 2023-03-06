import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/store_service.dart';

class MainModel extends ChangeNotifier {
  
  final List<Movie> favouriteMovies = [];
  final List<Movie> _hiddenMovies = [];
  /* set favouriteMovies(List<Movie> movies) {
    favouriteMovies = movies;
  } */

  /* UnmodifiableListView<Movie> get favouriteMovies =>
      UnmodifiableListView(favouriteMovies); */

  void addMovie(Movie movie) async {
    movie.favourite = true;
    favouriteMovies.add(movie);
    print(favouriteMovies);
    notifyListeners();
  }

  void hideMovie(Movie movie) {
    _hiddenMovies.add(movie);
    print(_hiddenMovies);
    notifyListeners();
  }

  bool containsMovie(Movie movie) {
    return favouriteMovies.contains(movie);
  }

  void unhideMovie(Movie movie) {
    _hiddenMovies.remove(movie);
    print(_hiddenMovies);
    notifyListeners();
  }

  void removeMovie(Movie movie) {
    favouriteMovies.remove(movie);
    movie.favourite = false;
    print(favouriteMovies);
    notifyListeners();
  }
}
