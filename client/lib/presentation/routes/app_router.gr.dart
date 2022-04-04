// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

part of 'app_router.dart';

class _$AppRouter extends RootStackRouter {
  _$AppRouter([GlobalKey<NavigatorState>? navigatorKey]) : super(navigatorKey);

  @override
  final Map<String, PageFactory> pagesMap = {
    SplashPageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(routeData: routeData, child: SplashPage());
    },
    LoginPageRoute.name: (routeData) {
      final args = routeData.argsAs<LoginPageRouteArgs>(
          orElse: () => const LoginPageRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child: LoginPage(key: args.key, onLoginResult: args.onLoginResult));
    },
    PlayersPageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const PlayersPage());
    },
    RegisterPageRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterPageRouteArgs>(
          orElse: () => const RegisterPageRouteArgs());
      return MaterialPageX<dynamic>(
          routeData: routeData,
          child:
              RegisterPage(key: args.key, onLoginResult: args.onLoginResult));
    },
    GamePageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const GamePage());
    },
    NoPageRoute.name: (routeData) {
      return MaterialPageX<dynamic>(
          routeData: routeData, child: const NoPage());
    }
  };

  @override
  List<RouteConfig> get routes => [
        RouteConfig(SplashPageRoute.name, path: '/'),
        RouteConfig(LoginPageRoute.name, path: '/login'),
        RouteConfig(PlayersPageRoute.name, path: '/home'),
        RouteConfig(RegisterPageRoute.name, path: '/register'),
        RouteConfig(GamePageRoute.name, path: '/game/:id'),
        RouteConfig(NoPageRoute.name, path: '/nopage')
      ];
}

/// generated route for
/// [SplashPage]
class SplashPageRoute extends PageRouteInfo<void> {
  const SplashPageRoute() : super(SplashPageRoute.name, path: '/');

  static const String name = 'SplashPageRoute';
}

/// generated route for
/// [LoginPage]
class LoginPageRoute extends PageRouteInfo<LoginPageRouteArgs> {
  LoginPageRoute({Key? key, void Function(bool)? onLoginResult})
      : super(LoginPageRoute.name,
            path: '/login',
            args: LoginPageRouteArgs(key: key, onLoginResult: onLoginResult));

  static const String name = 'LoginPageRoute';
}

class LoginPageRouteArgs {
  const LoginPageRouteArgs({this.key, this.onLoginResult});

  final Key? key;

  final void Function(bool)? onLoginResult;

  @override
  String toString() {
    return 'LoginPageRouteArgs{key: $key, onLoginResult: $onLoginResult}';
  }
}

/// generated route for
/// [PlayersPage]
class PlayersPageRoute extends PageRouteInfo<void> {
  const PlayersPageRoute() : super(PlayersPageRoute.name, path: '/home');

  static const String name = 'PlayersPageRoute';
}

/// generated route for
/// [RegisterPage]
class RegisterPageRoute extends PageRouteInfo<RegisterPageRouteArgs> {
  RegisterPageRoute({Key? key, void Function(bool)? onLoginResult})
      : super(RegisterPageRoute.name,
            path: '/register',
            args:
                RegisterPageRouteArgs(key: key, onLoginResult: onLoginResult));

  static const String name = 'RegisterPageRoute';
}

class RegisterPageRouteArgs {
  const RegisterPageRouteArgs({this.key, this.onLoginResult});

  final Key? key;

  final void Function(bool)? onLoginResult;

  @override
  String toString() {
    return 'RegisterPageRouteArgs{key: $key, onLoginResult: $onLoginResult}';
  }
}

/// generated route for
/// [GamePage]
class GamePageRoute extends PageRouteInfo<void> {
  const GamePageRoute() : super(GamePageRoute.name, path: '/game/:id');

  static const String name = 'GamePageRoute';
}

/// generated route for
/// [NoPage]
class NoPageRoute extends PageRouteInfo<void> {
  const NoPageRoute() : super(NoPageRoute.name, path: '/nopage');

  static const String name = 'NoPageRoute';
}
