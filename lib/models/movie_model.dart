import 'dart:convert';

class Movie {
  Movie(this.title, this.description, this.poster, this.rating, this.favourite);

  final String title;
  final String description;
  final String poster;
  final String rating;
  bool favourite;

  Movie.fromJson(Map<String, dynamic> json)
      : title = json['original_title'],
        description = json['overview'],
        poster = json['poster_path'],
        rating = json['vote_average'].toString(),
        favourite = false;
  static Map<String, dynamic> toMap(Movie movie) => {
        'title': movie.title,
        'description': movie.description,
        'poster': movie.poster,
        'rating': movie.rating,
        'favourite': movie.favourite,
      };

  static String encode(List<Movie> movies) => json.encode(
        movies
            .map<Map<String, dynamic>>(
              (movie) => Movie.toMap(movie),
            )
            .toList(),
      );
  static List<Movie> decode(String movies) =>
      (json.decode(movies) as List<dynamic>)
          .map<Movie>((item) => Movie.fromJson(item))
          .toList();

  @override
  String toString() => '$title, $description, $rating';
}
