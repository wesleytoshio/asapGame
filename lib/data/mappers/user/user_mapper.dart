import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/user_entity.dart';
import '../../models/user/user_model.dart';

class UserMapper {
  static UserEntity modelToEntity(UserModel model) {
    return UserEntity(
      email: model.email,
      name: model.name,
      status: model.status,
      uid: model.uid,
      picture: model.picture,
    );
  }

  static UserModel entityToModel(UserEntity entity) {
    return UserModel(
      email: entity.email,
      name: entity.name,
      status: entity.status,
      uid: entity.uid,
      picture: entity.picture,
    );
  }

  static UserModel fromSnapshotToEntity(
      DocumentSnapshot<Object?> documentSnapshot) {
    return UserModel(
      email: documentSnapshot['email'],
      name: documentSnapshot['name'],
      status: documentSnapshot['status'],
      uid: documentSnapshot['uid'],
      picture: documentSnapshot['picture'],
    );
  }

  static UserEntity localDataToEntity(Map<dynamic, dynamic> json) {
    return UserEntity(
      email: json['email'],
      name: json['name'],
      status: json['status'],
      uid: json['uid'],
      picture: json['picture'],
    );
  }
}
