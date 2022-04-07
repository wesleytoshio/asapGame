import 'package:animate_do/animate_do.dart';
import 'package:asap_game/domain/entities/user_entity.dart';
import 'package:asap_game/infra/constants/global/sounds.dart';
import 'package:asap_game/presentation/pages/game/controller/game_controller.dart';
import 'package:asap_game/presentation/themes/theme_const.dart';
import 'package:breathing_collection/breathing_collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobx/mobx.dart';

import '../../../di/injectable.dart';
import '../../widgets/animations/boucing.dart';
import 'widgets/game_header.dart';
import 'widgets/game_option.dart';
import 'widgets/game_timeleft.dart';
import 'widgets/player_grid_tile.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late AnimationController _playgroundAnimationController;
  late Animation<double> _playgroundAnimation;
  final GameController controller = getIt.get<GameController>();
  DocumentSnapshot? game;
  @override
  void initState() {
    super.initState();
    controller.stopwatchPlayers();
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

    reaction((_) => controller.currentRound.stage, (_) async {
      controller.shiftEnded = false;
      if (identical(controller.currentRound.stage, GameStage.interval)) {
        _playgroundAnimationController.reverse();
        await controller.playSound(SoundsEffects.timer);
      } else if (identical(
              controller.currentRound.stage, GameStage.responding) &&
          !controller.shiftEnded) {
        await controller.playSound(SoundsEffects.round);
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
                  print(controller.currentRound.stage.toString());
                  return Expanded(
                    child: Visibility(
                      visible:
                          controller.currentRound.stage != GameStage.waiting,
                      replacement: Center(
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
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 5,
                                mainAxisSpacing: 5,
                              ),
                              children: [
                                PlayerGridTile(
                                  ready: true,
                                  user: UserEntity(
                                      name: 'Geovanna',
                                      picture:
                                          'https://i.pravatar.cc/150?img=47'),
                                ),
                                PlayerGridTile(
                                  user: UserEntity(
                                      name: 'Mariana',
                                      picture:
                                          'https://i.pravatar.cc/150?img=5'),
                                ),
                                PlayerGridTile(
                                  user: UserEntity(
                                      name: 'Emmanuel',
                                      picture:
                                          'https://i.pravatar.cc/150?img=8'),
                                ),
                                PlayerGridTile(
                                  ready: true,
                                  user: UserEntity(
                                      name: 'Você',
                                      picture:
                                          'https://i.pravatar.cc/150?img=12'),
                                ),
                              ],
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
                                onPressed: controller.saveAnswer,
                                answer: controller.currentRound.answer,
                                text:
                                    "Tem entre 2 a 4 litros. São retirados 450 mililitros"),
                            GameOption(
                              onPressed: controller.saveAnswer,
                              answer: controller.currentRound.answer,
                              text:
                                  "Tem entre 4 a 6 litros. São retirados 450 mililitros",
                              isCorrect: true,
                            ),
                            GameOption(
                                onPressed: controller.saveAnswer,
                                answer: controller.currentRound.answer,
                                text: "Tem 10 litros. São retirados 2 litros"),
                            GameOption(
                                onPressed: controller.saveAnswer,
                                answer: controller.currentRound.answer,
                                text: "Tem 7 litros. São retirados 1,5 litros"),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
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
                                            controller.currentRound.heResponded!
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
