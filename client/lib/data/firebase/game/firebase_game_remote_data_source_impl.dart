import 'package:asap_game/data/local/user/user_local_data_source.dart';
import 'package:asap_game/data/models/game/game_board_model.dart';
import 'package:asap_game/domain/entities/game_board_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injectable/injectable.dart';

import '../../../infra/constants/endpoints/firestore/firestore_endpoints.dart';
import 'firebase_game_remote_data_source.dart';

@LazySingleton(as: FirebaseGameRemoteDataSource)
class FirebaseGameRemoteDataSourceImpl implements FirebaseGameRemoteDataSource {
  final FirebaseFirestore firestore;
  final UserLocalDataSource userLocalDataSource;
  FirebaseGameRemoteDataSourceImpl({
    required this.firestore,
    required this.userLocalDataSource,
  });

  @override
  Future<void> createGame(GameBoardEntity gameEntity) async {}

  @override
  Future<void> deleteGame(GameBoardEntity gameEntity) async {}

  @override
  Stream<List<GameBoardEntity>> getGames(String uid) {
    final noteCollectionRef = firestore
        .collection(FirestoreEndpoints.users)
        .doc(uid)
        .collection(FirestoreEndpoints.gamesPlayers);

    return noteCollectionRef.snapshots().map((querySnap) {
      return querySnap.docs
          .map((docSnap) => GameBoardModel.fromSnapshot(docSnap))
          .toList();
    });
  }

  @override
  Future<void> updateGame(GameBoardEntity note) async {}
}
