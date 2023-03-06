import 'package:flutter/cupertino.dart';
import 'package:movie_app/const.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/styles/text_styles.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(movie.title),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                  height: 400, child: Image.network(imagePath + movie.poster)),
              ShaderMask(
                shaderCallback: (bounds) => ratingGradient.createShader(bounds),
                child: Text(movie.rating, style: ratingStyle),
              ),
              Text(
                movie.description,
                style: descriptionStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
