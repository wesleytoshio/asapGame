import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../domain/entities/user_entity.dart';
import '../../../widgets/avatars/circle_avatar_with_badge.dart';

class PlayerInGameCard extends StatelessWidget {
  final UserEntity player;
  const PlayerInGameCard({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        PlayerInGameCardAvatar(player: player),
        const SizedBox(width: 12),
        PlayerInGameName(player: player),
      ],
    );
  }
}

class PlayerInGameCardAvatar extends StatelessWidget {
  const PlayerInGameCardAvatar({
    Key? key,
    required this.player,
  }) : super(key: key);

  final UserEntity player;

  @override
  Widget build(BuildContext context) {
    return CircleAvatarWithBadge(
      size: 45,
      backgroundImage: NetworkImage(player.picture!),
      borderOffset: .9,
      position: Offset(-16, -16),
      badgeConstraints: BoxConstraints(minHeight: 20, minWidth: 20),
      badgeBackgroundColor: Colors.white,
      badge: Icon(
        Ionicons.checkmark,
        size: 16,
      ),
      onPressedBadge: () {},
    );
  }
}

class EnemyInGameCard extends StatelessWidget {
  final UserEntity player;
  const EnemyInGameCard({
    Key? key,
    required this.player,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        PlayerInGameName(player: player),
        const SizedBox(width: 10),
        PlayerInGameCardAvatar(player: player),
      ],
    );
  }
}

class PlayerInGameName extends StatelessWidget {
  const PlayerInGameName({
    Key? key,
    required this.player,
  }) : super(key: key);

  final UserEntity player;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            player.name!,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
          ),
          Text(
            'Ranking 16',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Colors.white,
                ),
          ),
        ],
      ),
    );
  }
}
