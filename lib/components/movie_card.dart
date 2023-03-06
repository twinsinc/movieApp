import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/const.dart';
import 'package:movie_app/models/main_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/screens/movie_screen.dart';
import 'package:movie_app/styles/text_styles.dart';
import 'package:provider/provider.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({required this.movie, Key? key}) : super(key: key);
  final Movie movie;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
      builder: (context, mainModel, child) {
        return GestureDetector(
          onTap: () => Navigator.of(context).push(
            CupertinoPageRoute(
              builder: (context) => MovieScreen(movie: movie),
            ),
          ),
          child: Container(
            color: Colors.transparent,
            margin: const EdgeInsets.all(10),
            height: 200,
            child: Row(
              children: [
                CupertinoContextMenu(
                  actions: <Widget>[
                    CupertinoContextMenuAction(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      trailingIcon: CupertinoIcons.eye_slash,
                      child: const Text('Hide'),
                    ),
                    movie.favourite
                        ? CupertinoContextMenuAction(
                            onPressed: () {
                              Provider.of<MainModel>(context, listen: false)
                                  .removeMovie(movie);
                              Navigator.pop(context);
                            },
                            isDestructiveAction: true,
                            trailingIcon: CupertinoIcons.delete,
                            child: const Text('Unsave'),
                          )
                        : CupertinoContextMenuAction(
                            onPressed: () {
                              Provider.of<MainModel>(context, listen: false)
                                  .addMovie(movie);
                              Navigator.pop(context);
                            },
                            trailingIcon: CupertinoIcons.heart,
                            child: const Text('Save'),
                          ),
                  ],
                  child: Image.network(imagePath + movie.poster),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          movie.title,
                          style: titleStyle,
                        ),
                        const Text('Rating: '),
                        ShaderMask(
                          shaderCallback: (bounds) =>
                              ratingGradient.createShader(bounds),
                          child: Text(movie.rating, style: ratingStyle),
                        ),
                        Text(
                          movie.description,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 3,
                          style: descriptionStyle,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
