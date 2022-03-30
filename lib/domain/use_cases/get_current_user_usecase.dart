import 'package:injectable/injectable.dart';

import '../entities/user_entity.dart';
import '../repositories/firebase_auth_repository.dart';

@LazySingleton()
class GetCurrentUserUseCase {
  final FirebaseAuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  Future<UserEntity> call() async {
    return repository.getCurrentUser();
  }
}
