// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map json) => UserModel(
      name: json['name'] as String?,
      email: json['email'] as String?,
      uid: json['uid'] as String?,
      status: json['status'] as String?,
      password: json['password'] as String?,
      picture: json['picture'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'name': instance.name,
      'email': instance.email,
      'status': instance.status,
      'uid': instance.uid,
      'password': instance.password,
      'picture': instance.picture,
    };
