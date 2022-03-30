import 'package:injectable/injectable.dart';

import '../repositories/firebase_auth_repository.dart';

@LazySingleton()
class SignInGoogleUseCase {
  final FirebaseAuthRepository repository;

  SignInGoogleUseCase({required this.repository});

  Future<void> call() async {
    return repository.signInGoogle();
  }
}
