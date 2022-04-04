import 'presentation/routes/app_router.dart';

enum Flavor { dev, prd }

class AppConfig {
  final Flavor flavor;
  final String baseUrl;
  final AppRouter appRouter;

  static late AppConfig _instance;

  factory AppConfig({
    required Flavor flavor,
    required String baseUrl,
    required AppRouter appRouter,
  }) {
    _instance = AppConfig._(flavor, baseUrl, appRouter);
    return _instance;
  }

  AppConfig._(this.flavor, this.baseUrl, this.appRouter);

  static AppConfig get instance => _instance;
}
