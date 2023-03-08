import 'package:flutter/cupertino.dart';
import 'package:movie_app/components/movie_card.dart';
import 'package:movie_app/models/main_model.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/connectivity_service.dart';
import 'package:movie_app/services/movie_service.dart';
import 'package:movie_app/styles/text_styles.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController textController;
  String title = '';

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    ConnectivityService().getConnectivity(context);
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CupertinoSearchTextField(
            controller: textController,
            placeholder: 'Search',
            onSubmitted: (String value) {
              setState(() {
                title = value;
              });
            },
            onSuffixTap: () {
              setState(() {
                title = '';
                textController.clear();
              });
            },
          ),
        ),
        title.isEmpty
            ? const Expanded(
                child: Center(
                  child: Text(
                    'Enter a title in the search bar to find a movie',
                    style: hintStyle,
                  ),
                ),
              )
            : Expanded(
                child: Consumer<MainModel>(
                  builder: (contex, mainModel, child) {
                    return showMovieList(mainModel);
                  },
                ),
              )
      ],
    );
  }

  FutureBuilder<Set<Movie>> showMovieList(MainModel mainModel) {
    return FutureBuilder<Set<Movie>>(
      future: MovieService().search(title, mainModel),
      builder: (context, snapshot) {
        Set<Movie>? movies = snapshot.data ?? {};
        if (snapshot.connectionState == ConnectionState.done &&
            movies.isNotEmpty) {
          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (BuildContext context, index) {
              return Dismissible(
                direction: DismissDirection.endToStart,
                key: Key(movies.elementAt(index).title),
                child: MovieCard(
                  movie: movies.elementAt(index),
                ),
                onDismissed: (direction) {
                  Provider.of<MainModel>(context, listen: false).hideMovie(
                    movies.elementAt(index),
                  );
                  movies.remove(
                    movies.elementAt(index),
                  );
                },
                background: Container(
                  color: CupertinoColors.destructiveRed,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 20.0),
                    child: Align(
                      child: Icon(
                        CupertinoIcons.eye_slash,
                        color: CupertinoColors.white,
                        size: 40,
                      ),
                      alignment: Alignment.centerRight,
                    ),
                  ),
                ),
              );
            },
          );
        }
        if (snapshot.connectionState == ConnectionState.done &&
            movies.isEmpty) {
          return const Center(
            child: Text(
              'No movies found, try again..',
              style: hintStyle,
            ),
          );
        } else {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
      },
    );
  }
}
