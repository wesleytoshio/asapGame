import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../infra/exceptions/auth_failure.dart';
import '../repositories/firebase_auth_repository.dart';

@LazySingleton()
class IsSignInUseCase {
  final FirebaseAuthRepository repository;

  IsSignInUseCase({required this.repository});

  Future<Either<AuthFailure, bool>> call() async {
    return repository.isSignIn();
  }
}
