import 'package:flutter/cupertino.dart';
import 'package:movie_app/components/movie_card.dart';
import 'package:movie_app/models/movie_model.dart';
import 'package:movie_app/services/movie_service.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: const Text('Movie App'),
        trailing: CupertinoButton(
          onPressed: () => MovieService.getPopularMovies(),
          child: const Icon(
            CupertinoIcons.search,
            color: CupertinoColors.black,
          ),
        ),
      ),
      child: FutureBuilder<List<Movie>>(
        future: MovieService.getPopularMovies(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            print(snapshot.error);
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, index) {
                return MovieCard(movie: snapshot.data![index]);
              },
            );
          } else {
            return const Center(
                child: CupertinoActivityIndicator(
              color: CupertinoColors.activeBlue,
            ));
          }
        },
      ),
    );
  }
}
