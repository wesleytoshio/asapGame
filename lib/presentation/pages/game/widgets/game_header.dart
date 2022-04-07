import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../di/injectable.dart';
import '../../../../domain/entities/user_entity.dart';
import '../controller/game_controller.dart';
import 'player_in_game.dart';

class GameHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GameController controller = getIt.get<GameController>();
    return Observer(builder: (context) {
      return Container(
        padding: const EdgeInsets.all(5),
        child: SafeArea(
          child: Row(
            children: [
              BackButton(),
              if (controller.currentRound.stage != GameStage.waiting)
                Expanded(
                  child: PlayerInGameCard(
                    player: UserEntity(
                      picture:
                          "https://br.web.img2.acsta.net/medias/nmedia/18/91/86/50/20166901.jpg",
                      name: "Ruth Gemmell",
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    });
  }
}
