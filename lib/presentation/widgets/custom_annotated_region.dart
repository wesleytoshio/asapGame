import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomAnnotationRegion extends StatelessWidget {
  final Widget child;
  final Brightness? brightness;
  final Color statusBarColor;
  const CustomAnnotationRegion(
      {Key? key,
      required this.child,
      this.brightness,
      this.statusBarColor = Colors.transparent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: statusBarColor,
        statusBarBrightness: brightness,
        statusBarIconBrightness: brightness,
      ),
      child: child,
    );
  }
}
