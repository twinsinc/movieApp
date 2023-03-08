import 'package:flutter/cupertino.dart';
import 'package:movie_app/const.dart';
import 'package:movie_app/models/main_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/styles/text_styles.dart';
import 'package:provider/provider.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, mainModel, child) {
      return CupertinoPageScaffold(
        navigationBar: CupertinoNavigationBar(
          trailing: GestureDetector(
            child: movie.favourite
                ? const Icon(
                    CupertinoIcons.heart_fill,
                    size: 25,
                  )
                : const Icon(
                    CupertinoIcons.heart,
                    size: 25,
                  ),
            onTap: () {
              movie.favourite
                  ? Provider.of<MainModel>(context, listen: false)
                      .removeMovie(movie)
                  : Provider.of<MainModel>(context, listen: false)
                      .addFavouriteMovie(movie);
            },
          ),
          middle: Text(
            movie.title,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 400,
                      child: movie.poster.isNotEmpty
                          ? Image.network(imagePath + movie.poster)
                          : const Text('No image'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          ratingGradient.createShader(bounds),
                      child: Text(movie.rating, style: ratingStyle),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      movie.description,
                      style: descriptionStyle,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
