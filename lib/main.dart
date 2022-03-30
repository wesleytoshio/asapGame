import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';

import './di/injectable.dart' as di;
import 'app_config.dart';
import 'presentation/app/app_widget.dart';
import 'presentation/routes/app_router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await di.init();

  final AppRouter _appRouter = AppRouter();
  AppConfig(
    flavor: Flavor.dev,
    baseUrl: 'api',
    appRouter: _appRouter,
  );
  runApp(AppWidget(
    appRouter: _appRouter,
  ));
}
