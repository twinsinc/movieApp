/* import 'package:movie_app/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoreService {
  static late SharedPreferences prefs;

  static getInstance() async {
    prefs = await SharedPreferences.getInstance();
    return prefs;
  }

  static void saveData(List<Movie> movies) async {
    getInstance();
    final String encodedData = Movie.encode(movies);

    await prefs.setString('movies_key', encodedData);
  }

  static Future<List<Movie>> fetchData() async {
    final String? movieString = prefs.getString('movies_key');
    final List<Movie> movies =
        movieString != null ? Movie.decode(movieString) : [];

    return movies;
  }
}
 */