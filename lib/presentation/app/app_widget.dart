import 'package:asap_game/presentation/themes/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../routes/app_router.dart';
import '../routes/router_observer.dart';

class AppWidget extends StatelessWidget {
  final AppRouter appRouter;
  const AppWidget({required this.appRouter});
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData(
      fontFamily: GoogleFonts.lexend().fontFamily,
    );
    return MaterialApp.router(
      routerDelegate: appRouter.delegate(
        navigatorObservers: () => [
          AppRouterObserver(),
        ],
      ),
      routeInformationParser: appRouter.defaultRouteParser(),
      debugShowCheckedModeBanner: false,
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: const Color(primaryColor),
        ),
      ),
    );
  }
}
