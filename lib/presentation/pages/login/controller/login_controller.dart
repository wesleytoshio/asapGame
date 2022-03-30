import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../../di/injectable.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/use_cases/get_current_user_usecase.dart';
import '../../../../domain/use_cases/save_current_user_usecase.dart';
import '../../../../domain/use_cases/sign_in_google_usecase.dart';
import '../../../../domain/use_cases/sign_in_usecase.dart';
import '../../../../domain/use_cases/sign_up_usecase.dart';
import '../../../app/app_controller.dart';

part 'login_controller.g.dart';

@injectable
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final SignInUseCase signInUseCase;
  final SignInGoogleUseCase signInGoogleUseCase;
  final SignUPUseCase signUPUseCase;
  final SaveCurrentUserUsecase saveCurrentUserUsecase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  _LoginControllerBase(this.getCurrentUserUseCase,
      {required this.signInGoogleUseCase,
      required this.signUPUseCase,
      required this.signInUseCase,
      required this.saveCurrentUserUsecase});

  Future<void> signInWithEmailAndPassword({required UserEntity user}) async {
    try {
      await signInUseCase.call(user);
      getIt<AppController>().setUser(await getCurrentUserUseCase());
    } catch (_) {
      print('submitSignIn $_');
    }
  }

  Future<void> signInWithGoogle() async {
    await signInGoogleUseCase();
    getIt<AppController>().setUser(await getCurrentUserUseCase());
  }

  Future<void> signUpWithEmailAndPassword({required UserEntity user}) async {
    try {
      await signUPUseCase.call(user);
    } catch (_) {
      print(_);
    }
  }
}
