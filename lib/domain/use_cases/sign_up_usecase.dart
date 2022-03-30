import 'package:injectable/injectable.dart';

import '../entities/user_entity.dart';
import '../repositories/firebase_auth_repository.dart';

@LazySingleton()
class SignUPUseCase {
  final FirebaseAuthRepository repository;

  SignUPUseCase({required this.repository});

  Future<void> call(UserEntity user) async {
    return repository.signUp(user);
  }
}
