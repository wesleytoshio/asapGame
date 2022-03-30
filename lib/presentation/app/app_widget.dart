import 'package:asap_game/di/injectable.dart';
import 'package:asap_game/presentation/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../routes/app_router.dart';
import '../routes/router_observer.dart';

class AppWidget extends StatelessWidget {
  final AppRouter appRouter;
  const AppWidget({required this.appRouter});
  @override
  Widget build(BuildContext context) {
    AppController _controller = getIt<AppController>();
    return Observer(builder: (context) {
      return MaterialApp.router(
        routerDelegate: appRouter.delegate(
          navigatorObservers: () => [
            AppRouterObserver(),
          ],
        ),
        routeInformationParser: appRouter.defaultRouteParser(),
        debugShowCheckedModeBanner: false,
        theme: _controller.themeData,
        // theme: theme.copyWith(
        //   colorScheme: theme.colorScheme.copyWith(
        //     primary: const Color(primaryColor),
        //   ),
        // ),
      );
    });
  }
}
