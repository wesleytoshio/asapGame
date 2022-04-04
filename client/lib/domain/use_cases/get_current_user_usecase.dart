import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../infra/exceptions/auth_failure.dart';
import '../entities/user_entity.dart';
import '../repositories/firebase_auth_repository.dart';

@LazySingleton()
class GetCurrentUserUseCase {
  final FirebaseAuthRepository repository;

  GetCurrentUserUseCase({required this.repository});

  Future<Either<AuthFailure, UserEntity>> call() async {
    return repository.getCurrentUser();
  }
}
