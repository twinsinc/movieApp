import 'package:flutter/cupertino.dart';
import 'package:movie_app/models/main_model.dart';
import 'package:movie_app/screens/main_screen.dart';
import 'package:movie_app/screens/search_screen.dart';
import 'package:movie_app/services/store_service.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  MainModel.init();
  runApp(
    ChangeNotifierProvider(
      create: (context) => MainModel(),
      child: const MyMovieApp(),
    ),
  );
}

class MyMovieApp extends StatelessWidget {
  const MyMovieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      debugShowCheckedModeBanner: false,
      home: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.tv),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(CupertinoIcons.search),
            label: 'Search',
          ),
        ]),
        tabBuilder: (context, index) {
          late final CupertinoTabView returnValue;
          switch (index) {
            case 0:
              returnValue = CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text('Favourite Movies'),
                  ),
                  child: SafeArea(
                    child: MainScreen(),
                  ),
                );
              });
              break;
            case 1:
              returnValue = CupertinoTabView(builder: (context) {
                return const CupertinoPageScaffold(
                  navigationBar: CupertinoNavigationBar(
                    middle: Text('Search'),
                  ),
                  child: SafeArea(
                    child: SearchScreen(),
                  ),
                );
              });
              break;
          }
          return returnValue;
        },
      ),
    );
  }
}
