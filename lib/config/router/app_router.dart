import 'package:go_router/go_router.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:cinemapedia/presentation/screens/screens.dart';

final appRouter = GoRouter(initialLocation: "/", routes: [
  ShellRoute(
      builder: (context, state, child) {
        return HomeScreen(childView: child);
      },
      routes: [
        GoRoute(
            path: "/",
            builder: (context, state) {
              return const HomeView();
            },
            routes: [
              GoRoute(
                  path: "movie/:id",
                  name: MovieScreen.name,
                  builder: (context, state) {
                    return MovieScreen(
                        movieId: state.pathParameters["id"] ?? "no-id");
                  }),
            ]),
        GoRoute(
          path: "/favorites",
          builder: (context, state) {
            return const FavoritesView();
          },
        ),
      ])

  // Rutas basicas padre/hijo
  // GoRoute(
  //   path: "/",
  //   name: HomeScreen.name,
  //   builder: (context, state) => const HomeScreen(childView: FavoriteView(),),
  //   routes: [
  //     GoRoute(
  //     path: "movie/:id",
  //     name: MovieScreen.name,
  //     builder: (context, state) {
  //       return MovieScreen(movieId: state.pathParameters["id"] ?? "no-id");
  //     }),
  //    ]
  // ),
]);
