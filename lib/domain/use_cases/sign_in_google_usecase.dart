import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../infra/exceptions/auth_failure.dart';
import '../repositories/firebase_auth_repository.dart';

@LazySingleton()
class SignInGoogleUseCase {
  final FirebaseAuthRepository repository;

  SignInGoogleUseCase({required this.repository});

  Future<Either<AuthFailure, void>> call() async {
    return repository.signInGoogle();
  }
}
