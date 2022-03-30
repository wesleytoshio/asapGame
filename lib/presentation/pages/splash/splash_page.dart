import 'package:asap_game/di/injectable.dart';
import 'package:asap_game/presentation/app/app_controller.dart';
import 'package:flutter/material.dart';

import '../../../app_config.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      var appController = getIt<AppController>();
      try {
        await appController.initializeApp();
        if (appController.user != null) {
          AppConfig.instance.appRouter.replaceNamed('/players');
        } else {
          AppConfig.instance.appRouter.replaceNamed('/login');
        }
      } catch (e) {
        AppConfig.instance.appRouter.replaceNamed('/login');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
    // return BlocConsumer<AuthCubit, AuthState>(listener: (
    //   context,
    //   state,
    // ) {
    //   if (state is Authenticated) {
    //     getIt<AppRouter>().replaceNamed('/players');
    //   } else {
    //     getIt<AppRouter>().replaceNamed('/login');
    //   }
    // }, builder: (context, snapshot) {
    //   return const Scaffold(
    //     body: Center(
    //       child: CircularProgressIndicator(),
    //     ),
    //   );
    // });
  }
}
