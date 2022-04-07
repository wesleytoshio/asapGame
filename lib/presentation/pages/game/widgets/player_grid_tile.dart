import 'package:animate_do/animate_do.dart';
import 'package:asap_game/presentation/pages/game/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';

import '../../../../domain/entities/user_entity.dart';
import '../../../widgets/avatars/circle_avatar_with_badge.dart';

class PlayerGridTile extends StatelessWidget {
  final UserEntity user;
  final GameStage gameState;
  final bool ready;
  const PlayerGridTile({
    Key? key,
    required this.user,
    this.gameState = GameStage.waiting,
    this.ready = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final readyColor = ready ? Colors.green : Colors.white;
    return ZoomIn(
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            RippleAnimation(
              repeat: !ready,
              key: ObjectKey(user),
              color: Colors.grey[400]!,
              minRadius: 50,
              ripplesCount: 6,
              child: CircleAvatarWithBadge(
                size: 100,
                scale: 1,
                backgroundColor: readyColor,
                backgroundImage: NetworkImage(user.picture!),
                borderOffset: .9,
                position: Offset(-7, -7),
                badgeConstraints: BoxConstraints(minHeight: 30, minWidth: 30),
                badgeBackgroundColor: readyColor,
                badge: Center(
                  child: ready
                      ? Icon(Icons.check, color: Colors.white)
                      : SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                          ),
                        ),
                ),
                badgePadding: const EdgeInsets.all(2),
                onPressedBadge: () {},
              ),
            ),
            const SizedBox(height: 10),
            if (gameState == GameStage.waiting)
              Text(
                user.name!,
                style: Theme.of(context).textTheme.subtitle1,
              ),
          ],
        ),
      ),
    );
  }
}
