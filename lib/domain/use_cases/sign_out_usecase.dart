import 'package:injectable/injectable.dart';

import '../repositories/firebase_auth_repository.dart';

@LazySingleton()
class SignOutUseCase {
  final FirebaseAuthRepository repository;

  SignOutUseCase({required this.repository});

  Future<void> call() async {
    return repository.signOut();
  }
}
