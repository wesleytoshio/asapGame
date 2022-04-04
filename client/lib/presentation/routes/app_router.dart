import 'package:asap_game/presentation/pages/game/game_page.dart';
import 'package:asap_game/presentation/pages/login/login_page.dart';
import 'package:asap_game/presentation/pages/players/players_page.dart';
import 'package:asap_game/presentation/pages/register/register_page.dart';
import 'package:asap_game/presentation/pages/splash/splash_page.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../pages/no_page/no_page.dart';

part 'app_router.gr.dart';

@MaterialAutoRouter(
  routes: <AutoRoute>[
    AutoRoute(page: SplashPage, path: '/', initial: true),
    AutoRoute(page: LoginPage, path: '/login'),
    AutoRoute(page: PlayersPage, path: '/home'),
    AutoRoute(page: RegisterPage, path: '/register'),
    AutoRoute(page: GamePage, path: '/game/:id'),
    AutoRoute(page: NoPage, path: '/nopage'),
    //RedirectRoute(path: '*', redirectTo: '/'),
  ],
)
class AppRouter extends _$AppRouter {}
