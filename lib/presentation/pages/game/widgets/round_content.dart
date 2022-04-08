import 'package:animate_do/animate_do.dart';
import 'package:asap_game/di/injectable.dart';
import 'package:asap_game/presentation/pages/game/controller/game_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../themes/theme_const.dart';
import 'game_option.dart';

class RoundContent extends StatefulWidget {
  @override
  State<RoundContent> createState() => _RoundContentState();
}

class _RoundContentState extends State<RoundContent> {
  final GameController controller = getIt.get<GameController>();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(builder: (context) {
      return FadeInUp(
        child: ListView(
          physics: const BouncingScrollPhysics(),
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  if (controller.currentRound.content != null)
                    Text(
                      controller.currentRound.content?.question ?? "",
                      style: Theme.of(context).textTheme.headline6,
                    ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Text("QUAL É A RESPOSTA CORRETA?",
                  style: Theme.of(context).textTheme.caption),
            ),
            for (var item in controller.currentRound.content!.options)
              GameOption(
                data: item,
                onPressed: controller.saveAnswer,
                answer: controller.currentRound.answer,
                heResponded: controller.currentRound.heResponded,
                text: "Tem entre 4 a 6 litros. São retirados 450 mililitros",
                isCorrect: true,
              )
          ],
        ),
      );
    });
  }
}
