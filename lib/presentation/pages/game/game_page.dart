import 'dart:async';

import 'package:animate_do/animate_do.dart';
import 'package:asap_game/domain/entities/user_entity.dart';
import 'package:asap_game/presentation/themes/theme_const.dart';
import 'package:asap_game/presentation/widgets/animations/boucing.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../widgets/avatars/circle_avatar_with_badge.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.primary,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            SliverGameHeader(),
            Expanded(
              child: SlideInUp(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: kDefaultPadding),
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          Text(
                            "Normalmente, quantos litros de sangue uma pessoa tem? Em média, quantos são retirados numa doação de sangue?",
                            style: Theme.of(context)
                                .textTheme
                                .headline6!
                                .copyWith(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(kDefaultPadding),
                      child: Text(
                        "QUAL É A RESPOSTA CORRETA?",
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(color: Colors.white),
                      ),
                    ),
                    GameOption(
                        text:
                            "Tem entre 2 a 4 litros. São retirados 450 mililitros"),
                    GameOption(
                      text:
                          "Tem entre 4 a 6 litros. São retirados 450 mililitros",
                      isCorrect: true,
                    ),
                    GameOption(text: "Tem 10 litros. São retirados 2 litros"),
                    GameOption(text: "Tem 7 litros. São retirados 1,5 litros"),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: SlideInUp(
                delay: Duration(milliseconds: 270),
                child: Row(
                  children: [
                    Bouncing(
                      onPressed: () {},
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                              50,
                              50,
                            ),
                            primary: Colors.black87,
                            elevation: 0,
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                              side: BorderSide(color: Colors.white, width: 2),
                            )),
                        onPressed: () {},
                        child: const Icon(Ionicons.volume_mute_outline),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Bouncing(
                          onPressed: () {},
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                  0,
                                  50,
                                ),
                                primary: Colors.green.shade400,
                                elevation: 0,
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                  side:
                                      BorderSide(color: Colors.white, width: 2),
                                )),
                            onPressed: () {},
                            child: const Text("Confirmar"),
                          ),
                        ),
                      ),
                    ),
                    Bouncing(
                      onPressed: () {},
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: Size(
                              50,
                              50,
                            ),
                            primary: Colors.redAccent,
                            elevation: 0,
                            textStyle: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                            shape: ContinuousRectangleBorder(
                              borderRadius: BorderRadius.circular(35),
                              side: BorderSide(color: Colors.white, width: 2),
                            )),
                        onPressed: () {},
                        child: const Icon(Ionicons.chatbubble_ellipses_outline),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
          // child: SafeArea(
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          //     child: Column(
          //       children: [
          //         CircleAvatarWithBadge(
          //           size: 70,
          //           backgroundImage: NetworkImage("https://i.pravatar.cc/300"),
          //           borderOffset: .9,
          //           child: Image.network("https://i.pravatar.cc/300"),
          //           position: Offset(-10, -12),
          //           badgeConstraints: BoxConstraints(minHeight: 25, minWidth: 25),
          //           badgeBackgroundColor: Colors.white,
          //           badge: WaitEnemyCircularIndicator(),
          //           onPressedBadge: () {},
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}

class GameOption extends StatelessWidget {
  final String text;
  final bool isCorrect;
  const GameOption({
    Key? key,
    required this.text,
    this.isCorrect = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onPressed: () {},
      child: Card(
        color: isCorrect ? Colors.green.shade400 : Colors.white,
        margin: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: 5),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(
            width: 2,
            color: isCorrect ? Colors.white : Colors.transparent,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  text,
                  style: TextStyle(
                    color: isCorrect ? Colors.white : Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaitEnemyCircularIndicator extends StatelessWidget {
  const WaitEnemyCircularIndicator({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 16,
      height: 16,
      child: CircularProgressIndicator(
        strokeWidth: 2.5,
      ),
    );
  }
}

class SliverGameHeader extends StatelessWidget {
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
            SlideInRight(
              child: Padding(
                padding: const EdgeInsets.only(right: kDefaultPadding),
                child: Row(
                  children: [GameTimeLeft()],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class GameTimeLeft extends StatefulWidget {
  const GameTimeLeft({
    Key? key,
  }) : super(key: key);

  @override
  State<GameTimeLeft> createState() => _GameTimeLeftState();
}

class _GameTimeLeftState extends State<GameTimeLeft> {
  int countDown = 30;
  late Timer _timer;
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (countDown == 0) {
          setState(() {
            timer.cancel();
          });
        } else {
          setState(() {
            countDown--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Ionicons.timer_outline, color: Colors.white),
        const SizedBox(width: 5),
        Text(
          '$countDown',
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(color: Colors.white),
        ),
      ],
    );
  }
}

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
      size: 55,
      backgroundImage: NetworkImage(player.picture!),
      borderOffset: .8,
      position: Offset(-15, -15),
      badgeConstraints: BoxConstraints(minHeight: 27, minWidth: 27),
      badgeBackgroundColor: Colors.white,
      badge: Text(
        "60",
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Theme.of(context).colorScheme.primary,
        ),
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
