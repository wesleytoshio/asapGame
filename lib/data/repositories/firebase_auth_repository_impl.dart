import 'package:injectable/injectable.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/firebase_auth_repository.dart';
import '../firebase/auth/firebase_auth_remote_data_source.dart';

@LazySingleton(as: FirebaseAuthRepository)
class FirebaseAuthRepositoryImpl extends FirebaseAuthRepository {
  final FirebaseAuthRemoteDataSource remoteDataSource;

  FirebaseAuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<void> saveCurrentUser(UserEntity user) async =>
      remoteDataSource.saveCurrentUser(user);

  @override
  Future<UserEntity> getCurrentUser() async =>
      remoteDataSource.getCurrentUser();

  @override
  Future<bool> isSignIn() async => remoteDataSource.isSignIn();

  @override
  Future<void> signIn(UserEntity user) async => remoteDataSource.signIn(user);

  @override
  Future<void> signOut() async => remoteDataSource.signOut();

  @override
  Future<void> signUp(UserEntity user) async => remoteDataSource.signUp(user);

  @override
  Future<String> getCurrentUId() async => remoteDataSource.getCurrentUId();
}
