import 'package:asap_game/data/mappers/user/user_mapper.dart';
import 'package:asap_game/domain/entities/user_entity.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import '../../../infra/constants/storage/hive_box.dart';
import '../../models/user/user_model.dart';

abstract class UserLocalDataSource {
  Future<void> clearUser();
  Future<void> saveUser(UserModel user);
  Future<UserEntity> currentUser();
}

@LazySingleton(as: UserLocalDataSource)
class UserLocalDataSourceImpl implements UserLocalDataSource {
  @override
  Future<void> clearUser() async => Hive.box(HiveBox.user).clear();

  @override
  Future<UserEntity> currentUser() async {
    try {
      return UserMapper.localDataToEntity(
        Hive.box(HiveBox.user).get(HiveBox.userLocalKey),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> saveUser(UserEntity user) {
    try {
      return Hive.box(HiveBox.user)
          .put(HiveBox.userLocalKey, UserMapper.entityToModel(user).toJson());
    } catch (e) {
      rethrow;
    }
  }
}
