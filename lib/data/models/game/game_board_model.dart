import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../domain/entities/game_board_entity.dart';

class GameBoardModel extends GameBoardEntity {
  GameBoardModel({
    final String? gameId,
    type,
    owner,
    final Timestamp? time,
    final Map<String, dynamic>? content,
  }) : super(
          gameId: gameId,
          type: type,
          owner: owner,
          time: time,
          content: content,
        );

  factory GameBoardModel.fromSnapshot(DocumentSnapshot documentSnapshot) {
    return GameBoardModel(
      gameId: documentSnapshot.get('gameId'),
      type: documentSnapshot.get('type'),
      owner: documentSnapshot.get('owner'),
      time: documentSnapshot.get('time'),
      content: documentSnapshot.get('content'),
    );
  }
}
