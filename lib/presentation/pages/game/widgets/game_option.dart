import 'package:flutter/material.dart';

import '../../../../infra/utils/color_utils.dart';
import '../../../themes/theme_const.dart';
import '../../../widgets/animations/boucing.dart';

class GameOption extends StatelessWidget {
  final String text;
  final bool isCorrect;
  final dynamic answer;
  final Function(String)? onPressed;
  const GameOption({
    Key? key,
    required this.text,
    this.isCorrect = false,
    this.answer,
    this.onPressed,
  }) : super(key: key);

  Color get getFeedbackColor =>
      (answer != null) && (answer == text) && isCorrect
          ? Colors.green.shade400
          : (answer != null) && (answer != text) && isCorrect
              ? Colors.red
              : Colors.white;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onPressed: () {
        onPressed!(text);
      },
      child: Card(
        color: getFeedbackColor,
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
                    color: ColorUtils.getColorByLuminance(getFeedbackColor),
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
