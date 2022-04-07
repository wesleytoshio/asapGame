import '../../../domain/entities/game_board_entity.dart';

abstract class FirebaseGameRemoteDataSource {
  Future<void> createGame(GameBoardEntity note);
  Future<void> updateGame(GameBoardEntity note);
  Future<void> deleteGame(GameBoardEntity note);
  Stream<List<GameBoardEntity>> getGames(String gameId);
}
