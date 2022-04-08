import 'package:animate_do/animate_do.dart';
import 'package:asap_game/presentation/pages/game/controller/game_controller.dart';
import 'package:asap_game/presentation/pages/game/widgets/round_lobby.dart';
import 'package:asap_game/presentation/themes/theme_const.dart';
import 'package:breathing_collection/breathing_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobx/mobx.dart';

import '../../../di/injectable.dart';
import '../../../infra/constants/global/sounds.dart';
import '../../widgets/animations/boucing.dart';
import 'widgets/game_header.dart';
import 'widgets/game_timeleft.dart';
import 'widgets/round_content.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  final GameController controller = getIt.get<GameController>();

  @override
  void initState() {
    super.initState();
    controller.stopwatchPlayers();
    reaction((_) => controller.currentRound.stage, (_) async {
      controller.shiftEnded = false;
      if (identical(controller.currentRound.stage, GameStage.interval)) {
        await controller.playSound(SoundsEffects.timer);
      } else if (identical(
              controller.currentRound.stage, GameStage.responding) &&
          !controller.shiftEnded) {
        await controller.playSound(SoundsEffects.round);
      }
    });
  }

  @override
  void dispose() {
    controller.cancelTimer();
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
                Expanded(
                  child: Observer(builder: (context) {
                    if (controller.currentRound.stage == GameStage.waiting) {
                      return RoundLobby();
                    }
                    if (controller.currentRound.stage == GameStage.responding) {
                      return RoundContent();
                    }

                    return Container();
                  }),
                ),
                Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Observer(builder: (context) {
                    return SlideInUp(
                      delay: Duration(milliseconds: 270),
                      child: Row(
                        children: [
                          Bouncing(
                            onPressed: controller.setSound,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  minimumSize: Size(
                                    50,
                                    50,
                                  ),
                                  primary: Colors.white,
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  )),
                              onPressed: () {},
                              child: Visibility(
                                visible: controller.soundOn,
                                child: Icon(
                                  Ionicons.volume_high_outline,
                                  color: Colors.black,
                                ),
                                replacement: Icon(
                                  Ionicons.volume_mute_outline,
                                  color: Colors.black,
                                ),
                              ),
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
                                          borderRadius:
                                              BorderRadius.circular(35),
                                          side: BorderSide(
                                              color: Colors.white, width: 2),
                                        )),
                                    onPressed: controller
                                                    .currentRound.heResponded ==
                                                null ||
                                            controller.currentRound.heResponded
                                        ? null
                                        : controller.send,
                                    child: Text("Enviar"),
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
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  shape: ContinuousRectangleBorder(
                                    borderRadius: BorderRadius.circular(35),
                                  )),
                              onPressed: () {
                                controller.currentRound
                                    .copyWith(stage: GameStage.interval);
                              },
                              child: const Icon(
                                  Ionicons.chatbubble_ellipses_outline,
                                  color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                )
              ],
            ),
            GameHeader(),
            Observer(builder: (context) {
              return AnimatedAlign(
                alignment: controller.currentRound.stage != GameStage.interval
                    ? Alignment.topRight
                    : Alignment.center,
                duration: Duration(milliseconds: 300),
                onEnd: () {
                  controller.shiftEnded = true;
                },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (controller.currentRound.stage != GameStage.interval)
                      Padding(
                          padding: EdgeInsets.only(
                            top: kToolbarHeight,
                            right: kDefaultPadding,
                          ),
                          child: GameTimeleft()),
                    if (controller.currentRound.stage == GameStage.interval)
                      Column(
                        children: [
                          FadeIn(
                            child: Text.rich(
                              TextSpan(
                                text: controller.stopwatch.toString(),
                                children: [
                                  TextSpan(
                                    text: '',
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
