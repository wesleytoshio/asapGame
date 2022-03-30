import 'package:injectable/injectable.dart';

import '../repositories/firebase_auth_repository.dart';

@LazySingleton()
class IsSignInUseCase {
  final FirebaseAuthRepository repository;

  IsSignInUseCase({required this.repository});

  Future<bool> call() async {
    return repository.isSignIn();
  }
}
