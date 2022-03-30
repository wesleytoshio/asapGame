import 'package:injectable/injectable.dart';

import '../entities/user_entity.dart';
import '../repositories/firebase_auth_repository.dart';

@LazySingleton()
class SignInUseCase {
  final FirebaseAuthRepository repository;

  SignInUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.signIn(user);
  }
}
