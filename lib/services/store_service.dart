import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;
  static const _favouriteMoviesKey = 'favouriteMovies';
  static const _hiddenMoviesKey = 'hiddenMovies';

  static Future init() async => _prefs = await SharedPreferences.getInstance();

  static Future setFavouriteMovies(String movies) async {
    await _prefs.setString(_favouriteMoviesKey, movies);
  }

  static Future setHiddenMovies(String movies) async {
    await _prefs.setString(_hiddenMoviesKey, movies);
  }

  static String? getFavouriteMovies() => _prefs.getString(_favouriteMoviesKey);

  static String? getHiddenMovies() => _prefs.getString(_hiddenMoviesKey);
}
