// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

import 'package:cloud_firestore/cloud_firestore.dart' as _i4;
import 'package:firebase_auth/firebase_auth.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/firebase/auth/firebase_auth_remote_data_source.dart' as _i6;
import '../data/firebase/auth/firebase_auth_remote_data_source_impl.dart'
    as _i7;
import '../data/firebase/game/firebase_game_remote_data_source.dart' as _i10;
import '../data/firebase/game/firebase_game_remote_data_source_impl.dart'
    as _i11;
import '../data/local/user/user_local_data_source.dart' as _i5;
import '../data/repositories/firebase_auth_repository_impl.dart' as _i9;
import '../data/repositories/firebase_game_repository_impl.dart' as _i13;
import '../domain/repositories/firebase_auth_repository.dart' as _i8;
import '../domain/repositories/firebase_game_repository.dart' as _i12;
import '../domain/use_cases/get_current_user_usecase.dart' as _i14;
import '../domain/use_cases/is_sign_in_usecase.dart' as _i15;
import '../domain/use_cases/save_current_user_usecase.dart' as _i16;
import '../domain/use_cases/sign_in_usecase.dart' as _i17;
import '../domain/use_cases/sign_out_usecase.dart' as _i18;
import '../domain/use_cases/sign_up_usecase.dart' as _i19;
import '../infra/services/firebase_injectable_module.dart' as _i21;
import '../presentation/pages/login/controller/login_controller.dart'
    as _i20; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final firebaseInjectableModule = _$FirebaseInjectableModule();
  gh.lazySingleton<_i3.FirebaseAuth>(() => firebaseInjectableModule.auth);
  gh.lazySingleton<_i4.FirebaseFirestore>(
      () => firebaseInjectableModule.fireStore);
  gh.lazySingleton<_i5.UserLocalDataSource>(
      () => _i5.UserLocalDataSourceImpl());
  gh.lazySingleton<_i6.FirebaseAuthRemoteDataSource>(() =>
      _i7.FirebaseAuthRemoteDataSourceImpl(
          auth: get<_i3.FirebaseAuth>(),
          firestore: get<_i4.FirebaseFirestore>(),
          userLocalDataSource: get<_i5.UserLocalDataSource>()));
  gh.lazySingleton<_i8.FirebaseAuthRepository>(() =>
      _i9.FirebaseAuthRepositoryImpl(
          remoteDataSource: get<_i6.FirebaseAuthRemoteDataSource>()));
  gh.lazySingleton<_i10.FirebaseGameRemoteDataSource>(() =>
      _i11.FirebaseGameRemoteDataSourceImpl(
          firestore: get<_i4.FirebaseFirestore>(),
          userLocalDataSource: get<_i5.UserLocalDataSource>()));
  gh.lazySingleton<_i12.FirebaseGameRepository>(() =>
      _i13.FirebaseGameRepositoryImpl(
          remoteDataSource: get<_i10.FirebaseGameRemoteDataSource>()));
  gh.lazySingleton<_i14.GetCurrentUserUseCase>(() => _i14.GetCurrentUserUseCase(
      repository: get<_i8.FirebaseAuthRepository>()));
  gh.lazySingleton<_i15.IsSignInUseCase>(() =>
      _i15.IsSignInUseCase(repository: get<_i8.FirebaseAuthRepository>()));
  gh.lazySingleton<_i16.SaveCurrentUserUsecase>(() =>
      _i16.SaveCurrentUserUsecase(
          repository: get<_i8.FirebaseAuthRepository>()));
  gh.lazySingleton<_i17.SignInUseCase>(
      () => _i17.SignInUseCase(repository: get<_i8.FirebaseAuthRepository>()));
  gh.lazySingleton<_i18.SignOutUseCase>(
      () => _i18.SignOutUseCase(repository: get<_i8.FirebaseAuthRepository>()));
  gh.lazySingleton<_i19.SignUPUseCase>(
      () => _i19.SignUPUseCase(repository: get<_i8.FirebaseAuthRepository>()));
  gh.factory<_i20.LoginController>(() => _i20.LoginController(
      signUPUseCase: get<_i19.SignUPUseCase>(),
      signInUseCase: get<_i17.SignInUseCase>(),
      saveCurrentUserUsecase: get<_i16.SaveCurrentUserUsecase>()));
  return get;
}

class _$FirebaseInjectableModule extends _i21.FirebaseInjectableModule {}
