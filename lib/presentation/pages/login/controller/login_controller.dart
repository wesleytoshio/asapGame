import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:mobx/mobx.dart';

import '../../../../app_config.dart';
import '../../../../domain/entities/user_entity.dart';
import '../../../../domain/use_cases/get_current_user_usecase.dart';
import '../../../../domain/use_cases/save_current_user_usecase.dart';
import '../../../../domain/use_cases/sign_in_google_usecase.dart';
import '../../../../domain/use_cases/sign_in_usecase.dart';
import '../../../../domain/use_cases/sign_out_usecase.dart';
import '../../../../domain/use_cases/sign_up_usecase.dart';
import '../../../../infra/exceptions/auth_failure.dart';
import '../../../app/app_controller.dart';

part 'login_controller.g.dart';

@injectable
class LoginController = _LoginControllerBase with _$LoginController;

abstract class _LoginControllerBase with Store {
  final SignInUseCase signInUseCase;
  final SignInGoogleUseCase signInGoogleUseCase;
  final SignUPUseCase signUPUseCase;
  final SignOutUseCase signOutUseCase;
  final SaveCurrentUserUsecase saveCurrentUserUsecase;
  final GetCurrentUserUseCase getCurrentUserUseCase;
  final AppController appController;
  _LoginControllerBase(
      {required this.signInGoogleUseCase,
      required this.signOutUseCase,
      required this.signUPUseCase,
      required this.signInUseCase,
      required this.getCurrentUserUseCase,
      required this.appController,
      required this.saveCurrentUserUsecase});

  @observable
  Option<AuthFailure>? failure;

  @observable
  bool isLoading = false;

  Future<void> signInWithEmailAndPassword({required UserEntity user}) async {
    isLoading = true;
    var resultSignIn = await signInUseCase(user);
    resultSignIn.fold(
      (failure) {
        failure as AuthServerErrorFailure;
        isLoading = false;
      },
      (result) async => await getUserInfo(),
    );
  }

  Future<void> getUserInfo() async {
    var resultGetCurrentUser = await getCurrentUserUseCase();
    resultGetCurrentUser.fold((failure) {
      failure as AuthServerErrorFailure;
      isLoading = false;
    }, (useEntity) {
      isLoading = true;
      appController.setUser(useEntity);
      AppConfig.instance.appRouter.replaceNamed('/home');
    });
  }

  Future<void> signInWithGoogle() async {
    isLoading = true;
    var resultSignInGoogle = await signInGoogleUseCase();
    resultSignInGoogle.fold(
      (failure) {
        failure as AuthServerErrorFailure;
        isLoading = false;
      },
      (result) async => await getUserInfo(),
    );
  }

  Future<void> signUpWithEmailAndPassword({required UserEntity user}) async {
    isLoading = true;
    var resultsignUPUseCase = await signUPUseCase.call(user);
    resultsignUPUseCase.fold(
      (failure) {
        failure as AuthServerErrorFailure;
        isLoading = false;
      },
      (result) async => await getUserInfo(),
    );
  }
}
