import 'package:asap_game/di/injectable.dart';
import 'package:asap_game/presentation/pages/game/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../domain/entities/user_entity.dart';
import '../../../themes/theme_const.dart';
import 'player_grid_tile.dart';

class RoundLobby extends StatelessWidget {
  const RoundLobby({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GameController controller = getIt<GameController>();
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Observer(builder: (context) {
            return Text(
              controller.stopwatch.toString(),
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline2!
                  .copyWith(color: Colors.black),
            );
          }),
          Text(
            'Aguardando jogadores',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline5,
          ),
          const SizedBox(height: kDefaultPadding),
          GridView(
            shrinkWrap: true,
            padding: const EdgeInsets.all(kDefaultPadding),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5,
            ),
            children: [
              PlayerGridTile(
                ready: true,
                user: UserEntity(
                    name: 'Geovanna',
                    picture: 'https://i.pravatar.cc/150?img=47'),
              ),
              PlayerGridTile(
                ready: true,
                user: UserEntity(
                    name: 'Mariana',
                    picture: 'https://i.pravatar.cc/150?img=5'),
              ),
              PlayerGridTile(
                ready: true,
                user: UserEntity(
                    name: 'Emmanuel',
                    picture: 'https://i.pravatar.cc/150?img=8'),
              ),
              PlayerGridTile(
                ready: true,
                user: UserEntity(
                    name: 'Você', picture: 'https://i.pravatar.cc/150?img=12'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
