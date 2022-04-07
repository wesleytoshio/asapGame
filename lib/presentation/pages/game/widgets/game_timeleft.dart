import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../di/injectable.dart';
import '../controller/game_controller.dart';

class GameTimeleft extends StatelessWidget {
  const GameTimeleft({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GameController controller = getIt.get<GameController>();
    return Observer(builder: (contex) {
      return Visibility(
        visible: controller.currentRound.stage == GameStage.responding,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ZoomIn(
              child: Icon(
                Ionicons.timer_outline,
                size: 26,
              ),
            ),
            SizedBox(
                width: 65,
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      text: controller.stopwatch.toString(),
                      children: [
                        TextSpan(
                          text: 'seg.',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    style: Theme.of(context).textTheme.headline5,
                  ),
                )),
          ],
        ),
      );
    });
  }
}
