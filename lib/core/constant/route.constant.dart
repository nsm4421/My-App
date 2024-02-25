import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hot_place/presentation/main/page/main.screen.dart';
import 'package:hot_place/presentation/post/page/add_post.screen.dart';

import '../../presentation/splash.screen.dart';

enum Routes {
  splash("/"),
  main("/main"),
  addPost("/post/add");

  final String path;

  const Routes(this.path);
}

final GoRouter routerConfig = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      name: Routes.splash.name,
      path: Routes.splash.path,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),
    GoRoute(
      name: Routes.main.name,
      path: Routes.main.path,
      builder: (BuildContext context, GoRouterState state) {
        return const MainScreen();
      },
    ),
    GoRoute(
      name: Routes.addPost.name,
      path: Routes.addPost.path,
      builder: (BuildContext context, GoRouterState state) {
        return const AddPostScreen();
      },
    ),
  ],
);
