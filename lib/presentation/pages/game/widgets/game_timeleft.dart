import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

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
      return SizedBox(
        width: 30,
        child: Text(controller.timeleft.toString(),
            textDirection: TextDirection.ltr,
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: Colors.white,
                )),
      );
    });
  }
}
