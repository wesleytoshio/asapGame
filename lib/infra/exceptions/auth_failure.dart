class AuthFailure implements Exception {}

class AuthServerErrorFailure extends AuthFailure {
  final String? error;

  AuthServerErrorFailure({this.error});
}

class AuthNotFoundFailure extends AuthFailure {
  final String? error;

  AuthNotFoundFailure({this.error});
}

class AuthGoogleFailure extends AuthFailure {
  final String? error;

  AuthGoogleFailure({this.error});
}
