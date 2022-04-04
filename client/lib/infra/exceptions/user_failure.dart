class UserFailure implements Exception {}

class UserNotFoundFailure extends UserFailure {
  final String error;

  UserNotFoundFailure(this.error);
}

class UserServerErrorFailure extends UserFailure {
  final String error;

  UserServerErrorFailure(this.error);
}
