import 'package:cinemapedia/presentations/screens/screens.dart';
import 'package:cinemapedia/presentations/views/views.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(initialLocation: '/', routes: [
  ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
            path: '/',
            builder: (context, state) {
              return const HomeView();
            },
            routes: [
              GoRoute(
                path: 'movie/:id',
                name: MovieScreen.name,
                builder: (context, state) {
                  final movieId = state.pathParameters['id'] ?? 'no-id';

                  return MovieScreen(movieId: movieId);
                },
              ),
            ]),
        GoRoute(
          path: '/categories',
          builder: (context, state) {
            return  Scaffold(
              appBar: AppBar(
                title: const Text('Categories'),
              ),
              body: const Center(child: Text('Categories'),),
            );
          },
        ),
        GoRoute(
          path: '/favorites',
          builder: (context, state) {
            return const FavoritesView();
          },
        ),
      ]),
]);

//__________________Rutas Padre/hijo________________________
//   GoRoute(
//       path: '/',
//       name: HomeScreen.name,
//       builder: (context, state) => const HomeScreen(childView: HomeView()),
//       routes: [
//         GoRoute(
//     path: 'movie/:id',
//     name: MovieScreen.name,
//     builder: (context, state) {
//       final movieId = state.pathParameters['id'] ?? 'no-id';

//       return MovieScreen(movieId: movieId);
//     },
//   ),

//       ]),

