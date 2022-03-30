import 'package:get_it/get_it.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../infra/constants/storage/hive_box.dart';
import 'injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt', // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
Future<void> init() async {
  await Hive.initFlutter();
  await Hive.openBox(HiveBox.user);

  $initGetIt(getIt);
}
