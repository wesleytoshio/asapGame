import 'package:flutter/material.dart';

/// Oval bottom clipper to clip widget in oval shape at the bottom side
class OvalBottomBorderClipper extends CustomClipper<Path> {
  final double distance;

  OvalBottomBorderClipper({this.distance = 30});
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, 0);
    path.lineTo(0, size.height - distance);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - size.width / 4, size.height, size.width,
        size.height - distance);
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
