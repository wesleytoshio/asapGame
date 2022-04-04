import 'package:flutter/material.dart';

import '../../../themes/theme_const.dart';
import '../../../widgets/animations/boucing.dart';

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
