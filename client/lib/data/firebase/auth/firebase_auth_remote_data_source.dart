import 'package:dartz/dartz.dart';

import '../../../domain/entities/user_entity.dart';
import '../../../infra/exceptions/auth_failure.dart';

abstract class FirebaseAuthRemoteDataSource {
  Future<Either<AuthFailure, bool>> isSignIn();
  Future<Either<AuthFailure, Unit>> signIn(UserEntity user);
  Future<Either<AuthFailure, Unit>> signInGoogle();
  Future<Either<AuthFailure, Unit>> signUp(UserEntity user);
  Future<void> signOut();
  Future<Either<AuthFailure, UserEntity>> getCurrentUser();
  Future<String> getCurrentUId();
  Future<Either<AuthFailure, Unit>> saveCurrentUser(UserEntity user);
}
