// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/firebase/auth/firebase_auth_remote_data_source.dart' as _i7;
import '../data/firebase/auth/firebase_auth_remote_data_source_impl.dart'
    as _i8;
import '../data/firebase/game/firebase_game_remote_data_source.dart' as _i11;
import '../data/firebase/game/firebase_game_remote_data_source_impl.dart'
    as _i12;
import '../data/local/user/user_local_data_source.dart' as _i6;
import '../data/repositories/firebase_auth_repository_impl.dart' as _i10;
import '../data/repositories/firebase_game_repository_impl.dart' as _i14;
import '../domain/repositories/firebase_auth_repository.dart' as _i9;
import '../domain/repositories/firebase_game_repository.dart' as _i13;
import '../domain/use_cases/get_current_user_usecase.dart' as _i15;
import '../domain/use_cases/is_sign_in_usecase.dart' as _i16;
import '../domain/use_cases/save_current_user_usecase.dart' as _i17;
import '../domain/use_cases/sign_in_google_usecase.dart' as _i18;
import '../domain/use_cases/sign_in_usecase.dart' as _i19;
import '../domain/use_cases/sign_out_usecase.dart' as _i20;
import '../domain/use_cases/sign_up_usecase.dart' as _i21;
import '../infra/services/firebase/firebase_injectable_module.dart' as _i24;
import '../presentation/app/app_controller.dart' as _i22;
import '../presentation/pages/game/controller/game_controller.dart' as _i5;
import '../presentation/pages/login/controller/login_controller.dart'
    as _i23; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(() => firebaseInjectableModule.auth);
  gh.lazySingleton<_i4.FirebaseFirestore>(
      () => firebaseInjectableModule.fireStore);
  gh.lazySingleton<_i5.GameController>(() => _i5.GameController());
  gh.lazySingleton<_i6.UserLocalDataSource>(
      () => _i6.UserLocalDataSourceImpl());
  gh.lazySingleton<_i7.FirebaseAuthRemoteDataSource>(() =>
      _i8.FirebaseAuthRemoteDataSourceImpl(
          auth: get<_i3.FirebaseAuth>(),
          firestore: get<_i4.FirebaseFirestore>(),
          userLocalDataSource: get<_i6.UserLocalDataSource>()));
  gh.lazySingleton<_i9.FirebaseAuthRepository>(() =>
      _i10.FirebaseAuthRepositoryImpl(
          remoteDataSource: get<_i7.FirebaseAuthRemoteDataSource>()));
  gh.lazySingleton<_i11.FirebaseGameRemoteDataSource>(() =>
      _i12.FirebaseGameRemoteDataSourceImpl(
          firestore: get<_i4.FirebaseFirestore>(),
          userLocalDataSource: get<_i6.UserLocalDataSource>()));
  gh.lazySingleton<_i13.FirebaseGameRepository>(() =>
      _i14.FirebaseGameRepositoryImpl(
          remoteDataSource: get<_i11.FirebaseGameRemoteDataSource>()));
  gh.lazySingleton<_i15.GetCurrentUserUseCase>(() => _i15.GetCurrentUserUseCase(
      repository: get<_i9.FirebaseAuthRepository>()));
  gh.lazySingleton<_i16.IsSignInUseCase>(() =>
      _i16.IsSignInUseCase(repository: get<_i9.FirebaseAuthRepository>()));
  gh.lazySingleton<_i17.SaveCurrentUserUsecase>(() =>
      _i17.SaveCurrentUserUsecase(
          repository: get<_i9.FirebaseAuthRepository>()));
  gh.lazySingleton<_i18.SignInGoogleUseCase>(() =>
      _i18.SignInGoogleUseCase(repository: get<_i9.FirebaseAuthRepository>()));
  gh.lazySingleton<_i19.SignInUseCase>(
      () => _i19.SignInUseCase(repository: get<_i9.FirebaseAuthRepository>()));
  gh.lazySingleton<_i20.SignOutUseCase>(
      () => _i20.SignOutUseCase(repository: get<_i9.FirebaseAuthRepository>()));
  gh.lazySingleton<_i21.SignUPUseCase>(
      () => _i21.SignUPUseCase(repository: get<_i9.FirebaseAuthRepository>()));
  gh.singleton<_i22.AppController>(_i22.AppController(
      get<_i15.GetCurrentUserUseCase>(),
      get<_i16.IsSignInUseCase>(),
      get<_i20.SignOutUseCase>()));
  gh.factory<_i23.LoginController>(() => _i23.LoginController(
      signInGoogleUseCase: get<_i18.SignInGoogleUseCase>(),
      signOutUseCase: get<_i20.SignOutUseCase>(),
      signUPUseCase: get<_i21.SignUPUseCase>(),
      signInUseCase: get<_i19.SignInUseCase>(),
      getCurrentUserUseCase: get<_i15.GetCurrentUserUseCase>(),
      appController: get<_i22.AppController>(),
      saveCurrentUserUsecase: get<_i17.SaveCurrentUserUsecase>()));
  return get;
}

class _$FirebaseInjectableModule extends _i24.FirebaseInjectableModule {}
