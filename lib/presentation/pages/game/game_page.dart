import 'package:animate_do/animate_do.dart';
import 'package:asap_game/presentation/pages/game/controller/game_controller.dart';
import 'package:asap_game/presentation/themes/theme_const.dart';
import 'package:breathing_collection/breathing_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobx/mobx.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:sound_library/sound_library.dart';

import '../../../di/injectable.dart';
import '../../widgets/animations/boucing.dart';
import '../../widgets/avatars/circle_avatar_with_badge.dart';
import 'widgets/game_header.dart';
import 'widgets/game_option.dart';
import 'widgets/game_timeleft.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late AnimationController _playgroundAnimationController;
  late Animation<double> _playgroundAnimation;
  final GameController controller = getIt.get<GameController>();
  @override
  void initState() {
    super.initState();
    _playgroundAnimationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _playgroundAnimation =
        Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(
      parent: _playgroundAnimationController,
      curve: Curves.easeInOutQuad,
    ));

    _playgroundAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        // _playgroundAnimationController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        //_playgroundAnimationController.forward();
      }
    });
    //_playgroundAnimationController.forward();

    reaction((_) => controller.state, (_) {
      controller.shiftEnded = false;
      if (identical(controller.state, GameState.interval)) {
        _playgroundAnimationController.reverse();
      } else if (identical(controller.state, GameState.timeleft) &&
          !controller.shiftEnded) {
        _playgroundAnimationController.forward();
      }
    });
  }

  @override
  void dispose() {
    _playgroundAnimationController.dispose();
    controller.cancelTimeLeft();
    getIt.resetLazySingleton<GameController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: Stack(
          children: [
            BreathingBackground(
              initialMainColor: Colors.white,
              transformedMainColor: Colors.grey[200],
              initialSecondaryColor: Colors.grey[200],
              transformedSecondaryColor: Colors.grey[300],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              duration: Duration(seconds: 3),
            ),
            Column(
              children: [
                const SizedBox(height: 70),
                Observer(builder: (context) {
                  print(controller.state.toString());
                  return Expanded(
                    child: Visibility(
                      visible: controller.state != GameState.none,
                      replacement: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            RippleAnimation(
                              repeat: true,
                              color: Colors.grey[400]!,
                              minRadius: 90,
                              ripplesCount: 6,
                              child: CircleAvatarWithBadge(
                                size: 100,
                                scale: 1,
                                backgroundImage: NetworkImage(
                                    "https://br.web.img2.acsta.net/medias/nmedia/18/91/86/50/20166901.jpg"),
                                borderOffset: .9,
                                position: Offset(-7, -7),
                                badgeConstraints:
                                    BoxConstraints(minHeight: 32, minWidth: 32),
                                badgeBackgroundColor: Colors.white,
                                badge: SizedBox(
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                    ),
                                  ),
                                  width: 18,
                                  height: 18,
                                ),
                                badgePadding: const EdgeInsets.all(2),
                                onPressedBadge: () {},
                              ),
                            ),
                            const SizedBox(height: kDefaultPadding),
                            if (controller.state == GameState.none)
                              Text(
                                "Aguardando jogador",
                              ),
                          ],
                        ),
                      ),
                      child: FadeTransition(
                        opacity: _playgroundAnimation,
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
                                    style:
                                        Theme.of(context).textTheme.headline6,
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(kDefaultPadding),
                              child: Text("QUAL É A RESPOSTA CORRETA?",
                                  style: Theme.of(context).textTheme.caption),
                            ),
                            GameOption(
                                text:
                                    "Tem entre 2 a 4 litros. São retirados 450 mililitros"),
                            GameOption(
                              text:
                                  "Tem entre 4 a 6 litros. São retirados 450 mililitros",
                              isCorrect: true,
                            ),
                            GameOption(
                                text: "Tem 10 litros. São retirados 2 litros"),
                            GameOption(
                                text: "Tem 7 litros. São retirados 1,5 litros"),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: SlideInUp(
                    delay: Duration(milliseconds: 270),
                    child: Row(
                      children: [
                        Bouncing(
                          onPressed: () {
                            controller.state = GameState.timeleft;
                          },
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                  50,
                                  50,
                                ),
                                primary: Colors.white,
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                )),
                            onPressed: () {},
                            child: const Icon(Ionicons.volume_mute_outline,
                                color: Colors.black),
                          ),
                        ),
                        Observer(builder: (context) {
                          return Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Bouncing(
                                onPressed: () {},
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      minimumSize: Size(
                                        0,
                                        50,
                                      ),
                                      primary: Colors.green.shade400,
                                      textStyle: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(35),
                                        side: BorderSide(
                                            color: Colors.white, width: 2),
                                      )),
                                  onPressed: () async {
                                    SoundPlayer.setAudioEnabled(true);
                                    SoundPlayer.i.play(Sounds.click);
                                    controller.startTimeLeft();
                                  },
                                  child: Text(controller.state != GameState.none
                                      ? "Confirmar"
                                      : "Iniciar"),
                                ),
                              ),
                            ),
                          );
                        }),
                        Bouncing(
                          onPressed: () {},
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: Size(
                                  50,
                                  50,
                                ),
                                primary: Colors.white,
                                elevation: 2,
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                )),
                            onPressed: () {
                              controller.state = GameState.interval;
                            },
                            child: const Icon(
                                Ionicons.chatbubble_ellipses_outline,
                                color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            GameHeader(),
            Observer(builder: (context) {
              return AnimatedAlign(
                alignment: controller.state != GameState.interval
                    ? Alignment.topRight
                    : Alignment.center,
                duration: Duration(milliseconds: 300),
                onEnd: () {
                  controller.shiftEnded = true;
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.state != GameState.interval)
                      Padding(
                          padding: EdgeInsets.only(
                            top: kToolbarHeight,
                            right: kDefaultPadding,
                          ),
                          child: GameTimeleft()),
                    if (controller.state == GameState.interval)
                      Column(
                        children: [
                          FadeIn(
                            child: Text.rich(
                              TextSpan(
                                text: controller.timeleft.toString(),
                                children: [
                                  TextSpan(
                                    text: 'seg.',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ],
                              ),
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      fontSize:
                                          controller.shiftEnded ? 50 : null),
                            ),
                          ),
                          if (controller.shiftEnded)
                            ZoomIn(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: kDefaultPadding),
                                child: Text('Aguardo inicio da rodada.',
                                    style:
                                        Theme.of(context).textTheme.subtitle1),
                              ),
                            ),
                        ],
                      )
                  ],
                ),
              );
            })
          ],
        ),
      ),
    );
  }
}
