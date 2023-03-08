import 'package:flutter/cupertino.dart';
import 'package:movie_app/components/movie_card.dart';
import 'package:movie_app/models/main_model.dart';
import 'package:movie_app/styles/text_styles.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
      builder: (context, mainModel, child) {
        if (mainModel.favouriteMovies.isNotEmpty) {
          return ListView.builder(
            itemCount: mainModel.favouriteMovies.length,
            itemBuilder: (BuildContext context, index) {
              return MovieCard(
                  movie: mainModel.favouriteMovies.elementAt(index));
            },
          );
        } else {
          return const Center(
            child: Text(
              'Use search to find and add movies to your list',
              style: hintStyle,
            ),
          );
        }
      },
    );
  }
}
