import 'package:flutter/material.dart';

import 'package:flutter_cinemapedia/shared/widgets.dart';
import 'package:flutter_cinemapedia/features/movies/views.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'movies_screen';
  final int pageIndex;

  const HomeScreen({super.key, required this.pageIndex});

  final viewRoutes = const <Widget>[
    MoviesView(),
    SizedBox(), // <- categories view
    MoviesFavoritesView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: pageIndex,
        children: viewRoutes,
      ),
      bottomNavigationBar: CustomBottomNavigationBar(currentIndex: pageIndex),
    );
  }
}
