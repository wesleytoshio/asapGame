import 'package:animate_do/animate_do.dart';
import 'package:asap_game/presentation/pages/game/controller/game_controller.dart';
import 'package:asap_game/presentation/themes/theme_const.dart';
import 'package:asap_game/presentation/widgets/animations/boucing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';
import 'package:mobx/mobx.dart';

import '../../../di/injectable.dart';
import 'widgets/game_header.dart';
import 'widgets/game_option.dart';
import 'widgets/game_timeleft.dart';

class GamePage extends StatefulWidget {
  const GamePage({Key? key}) : super(key: key);

  @override
  State<GamePage> createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> with TickerProviderStateMixin {
  late AnimationController animation;
  late Animation<double> _fadeInFadeOut;
  final GameController controller = getIt.get<GameController>();
  @override
  void initState() {
    super.initState();

    animation = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
    );
    _fadeInFadeOut = Tween<double>(begin: 0, end: 1).animate(animation);

    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     animation.reverse();
    //   } else if (status == AnimationStatus.dismissed) {
    //     animation.forward();
    //   }
    // });

    reaction((_) => controller.state, (_) {
      if (identical(controller.state, GameState.interval)) {
        animation.reverse();
      } else if (identical(controller.state, GameState.timeleft) &&
          !controller.shiftEnded) {
        animation.forward();
      }
    });

    reaction((_) => controller.shiftEnded, (_) {
      if (identical(controller.state, GameState.timeleft) &&
          controller.shiftEnded) {
        animation.forward();
      }
    });
  }

  @override
  void dispose() {
    animation.dispose();
    controller.cancelTimeLeft();
    getIt.resetLazySingleton<GameController>();
    super.dispose();
  }

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
        body: Stack(
          children: [
            Column(
              children: [
                const SizedBox(height: 70),
                Observer(builder: (context) {
                  return Expanded(
                    child: FadeTransition(
                      opacity: _fadeInFadeOut,
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
                          GameOption(
                              text: "Tem 10 litros. São retirados 2 litros"),
                          GameOption(
                              text: "Tem 7 litros. São retirados 1,5 litros"),
                        ],
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
                          onPressed: () {},
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
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                    shape: ContinuousRectangleBorder(
                                      borderRadius: BorderRadius.circular(35),
                                      side: BorderSide(
                                          color: Colors.white, width: 2),
                                    )),
                                onPressed: controller.startTimeLeft,
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
                                primary: Colors.white,
                                elevation: 2,
                                textStyle: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                                shape: ContinuousRectangleBorder(
                                  borderRadius: BorderRadius.circular(35),
                                )),
                            onPressed: () {},
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
              if (controller.state != GameState.interval) {
                return Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: kToolbarHeight + 3.5,
                      right: kToolbarHeight,
                    ),
                    child: ZoomIn(
                        child:
                            Icon(Ionicons.timer_outline, color: Colors.white)),
                  ),
                );
              }
              return Container();
            }),
            Observer(builder: (context) {
              return AnimatedAlign(
                alignment: identical(controller.state, GameState.interval)
                    ? Alignment.center
                    : Alignment.topRight,
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
                      Text(
                        controller.timeleft.toString(),
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: Colors.white,
                            fontSize: controller.shiftEnded ? 50 : null),
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
