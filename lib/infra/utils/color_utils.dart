import 'package:flutter/material.dart';

class ColorUtils {
  static Color getColorByLuminance(Color color) {
    try {
      return color.computeLuminance() < 0.5 ? Colors.white : Colors.black;
    } catch (e) {
      return color;
    }
  }

  static Color primaryColorLuminance(BuildContext context) =>
      getColorByLuminance(Theme.of(context).colorScheme.primary);
}
