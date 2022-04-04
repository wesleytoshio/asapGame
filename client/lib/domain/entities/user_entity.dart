class UserEntity {
  final String? name;
  final String? email;
  final String? status;
  final String? uid;
  final String? password;
  final String? picture;
  UserEntity({
    this.name,
    this.email,
    this.status,
    this.uid,
    this.password,
    this.picture,
  });

  UserEntity copyWith({
    String? name,
    String? email,
    String? status,
    String? uid,
    String? password,
    String? picture,
  }) {
    return UserEntity(
      name: name ?? this.name,
      email: email ?? this.email,
      status: status ?? this.status,
      uid: uid ?? this.uid,
      password: password ?? this.password,
      picture: picture ?? this.picture,
    );
  }
}
