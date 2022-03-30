import '../entities/user_entity.dart';

abstract class FirebaseAuthRepository {
  Future<bool> isSignIn();
  Future<void> signIn(UserEntity user);
  Future<void> signUp(UserEntity user);
  Future<void> signOut();
  Future<UserEntity> getCurrentUser();
  Future<String> getCurrentUId();
  Future<void> saveCurrentUser(UserEntity user);
}
