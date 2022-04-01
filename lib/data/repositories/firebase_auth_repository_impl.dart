import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/firebase_auth_repository.dart';
import '../../infra/exceptions/auth_failure.dart';
import '../firebase/auth/firebase_auth_remote_data_source.dart';

@LazySingleton(as: FirebaseAuthRepository)
class FirebaseAuthRepositoryImpl extends FirebaseAuthRepository {
  final FirebaseAuthRemoteDataSource remoteDataSource;

  FirebaseAuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<AuthFailure, Unit>> saveCurrentUser(UserEntity user) async =>
      remoteDataSource.saveCurrentUser(user);

  @override
  Future<Either<AuthFailure, UserEntity>> getCurrentUser() async =>
      remoteDataSource.getCurrentUser();

  @override
  Future<Either<AuthFailure, bool>> isSignIn() async =>
      remoteDataSource.isSignIn();

  @override
  Future<Either<AuthFailure, Unit>> signIn(UserEntity user) async =>
      remoteDataSource.signIn(user);

  @override
  Future<Either<AuthFailure, Unit>> signInGoogle() async =>
      remoteDataSource.signInGoogle();

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<Either<AuthFailure, Unit>> signUp(UserEntity user) async =>
      remoteDataSource.signUp(user);

  @override
  Future<String> getCurrentUId() async => remoteDataSource.getCurrentUId();
}
