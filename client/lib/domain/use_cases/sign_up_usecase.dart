import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../infra/exceptions/auth_failure.dart';
import '../entities/user_entity.dart';
import '../repositories/firebase_auth_repository.dart';

@LazySingleton()
class SignUPUseCase {
  final FirebaseAuthRepository repository;

  SignUPUseCase({required this.repository});

  Future<Either<AuthFailure, void>> call(UserEntity user) async {
    return repository.signUp(user);
  }
}
