import 'package:flutter/material.dart';

import '../../../app_config.dart';

class SplashPage extends StatefulWidget {
  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      Future.delayed(const Duration(seconds: 1)).then((value) {
        AppConfig.instance.appRouter.replaceNamed('/login');
      });
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
