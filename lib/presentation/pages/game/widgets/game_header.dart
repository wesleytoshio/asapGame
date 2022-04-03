import 'package:flutter/material.dart';

import '../../../../domain/entities/user_entity.dart';
import 'player_in_game.dart';

class GameHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: SafeArea(
        child: Row(
          children: [
            BackButton(
              color: Colors.white,
            ),
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
  }
}
