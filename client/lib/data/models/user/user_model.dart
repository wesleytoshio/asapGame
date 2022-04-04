import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/user_entity.dart';

part 'user_model.g.dart';

@JsonSerializable(anyMap: true)
class UserModel extends UserEntity {
  UserModel({
    final String? name,
    final String? email,
    final String? uid,
    final String? status,
    final String? password,
    final String? picture,
  }) : super(
            uid: uid,
            name: name,
            email: email,
            password: password,
            status: status,
            picture: picture);

  // factory UserModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
  //   return UserModel(
  //     status: documentSnapshot.get('status'),
  //     name: documentSnapshot.get('name'),
  //     uid: documentSnapshot.get('uid'),
  //     email: documentSnapshot.get('email'),
  //     picture: documentSnapshot.get('picture'),
  //   );
  // }

  factory UserModel.fromJson(DocumentSnapshot json) =>
      _$UserModelFromJson(json.data() as Map);
  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
