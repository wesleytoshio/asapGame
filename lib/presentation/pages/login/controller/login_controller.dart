import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/use_cases/save_current_user_usecase.dart';
import '../../../../domain/use_cases/sign_in_google_usecase.dart';
import '../../../../domain/use_cases/sign_in_usecase.dart';
import '../../../../domain/use_cases/sign_up_usecase.dart';

part 'login_controller.g.dart';

@injectable
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final SignInUseCase signInUseCase;
  final SignInGoogleUseCase signInGoogleUseCase;
  final SignUPUseCase signUPUseCase;
  final SaveCurrentUserUsecase saveCurrentUserUsecase;
  _LoginControllerBase(
      {required this.signInGoogleUseCase,
      required this.signUPUseCase,
      required this.signInUseCase,
      required this.saveCurrentUserUsecase});

  Future<void> signInWithEmailAndPassword({required UserEntity user}) async {
    try {
      await signInUseCase.call(user);
    } catch (_) {
      print('submitSignIn $_');
    }
  }

  Future<void> signInWithGoogle() async => signInGoogleUseCase();

  Future<void> signUpWithEmailAndPassword({required UserEntity user}) async {
    try {
      await signUPUseCase.call(user);
    } catch (_) {}
  }
}
