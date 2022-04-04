import 'package:asap_game/domain/entities/game_board_entity.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repositories/firebase_game_repository.dart';
import '../firebase/game/firebase_game_remote_data_source.dart';

@LazySingleton(as: FirebaseGameRepository)
class FirebaseGameRepositoryImpl extends FirebaseGameRepository {
  final FirebaseGameRemoteDataSource remoteDataSource;

  FirebaseGameRepositoryImpl({required this.remoteDataSource});
  @override
  Future<void> createGame(GameBoardEntity note) async =>
      remoteDataSource.createGame(note);

  @override
  Future<void> deleteGame(GameBoardEntity note) async =>
      remoteDataSource.deleteGame(note);

  @override
  Stream<List<GameBoardEntity>> getGames(String gameId) =>
      remoteDataSource.getGames(gameId);

  @override
  Future<void> updateGame(GameBoardEntity note) async =>
      remoteDataSource.updateGame(note);
}
