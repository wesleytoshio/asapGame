import '../../../domain/entities/user_entity.dart';

abstract class FirebaseAuthRemoteDataSource {
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signInGoogle();
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<UserEntity> getCurrentUser();
  Future<String> getCurrentUId();
  Future<void> saveCurrentUser(UserEntity user);
}
