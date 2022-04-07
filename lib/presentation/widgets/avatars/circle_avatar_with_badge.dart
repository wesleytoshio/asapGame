import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class CircleAvatarWithBadge extends StatelessWidget {
  final double size;
  final Widget? badge;
  final Offset? position;
  final Function()? onPressedBadge;
  final EdgeInsetsGeometry badgePadding;
  final Color? badgeBackgroundColor;
  final double scale;
  final Widget? child;
  final ImageProvider<Object>? backgroundImage;
  final BoxConstraints badgeConstraints;
  final Duration badgeDelay;
  final Color backgroundColor;

  /// [.5] equal to [50%] of size;
  final double borderOffset;
  const CircleAvatarWithBadge({
    Key? key,
    required this.size,
    this.child,
    this.badge,
    this.position = const Offset(0, 0),
    this.onPressedBadge,
    this.scale = 1,
    this.badgePadding = EdgeInsets.zero,
    this.badgeBackgroundColor,
    this.borderOffset = .5,
    this.backgroundImage,
    this.badgeConstraints = const BoxConstraints(minHeight: 30, minWidth: 30),
    this.badgeDelay = const Duration(milliseconds: 0),
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: SizedBox(
        height: size,
        width: size,
        child: Stack(
          clipBehavior: Clip.none,
          fit: StackFit.expand,
          children: [
            CircleAvatar(
              backgroundColor: backgroundColor,
              radius: size,
              child: CircleAvatar(
                radius: size * borderOffset / 2,
                backgroundImage: backgroundImage,
                child: ClipOval(child: child),
              ),
            ),
            if (badge != null)
              Positioned(
                  bottom: position!.dy,
                  right: position!.dx,
                  child: ZoomIn(
                    delay: badgeDelay,
                    child: RawMaterialButton(
                      onPressed: onPressedBadge,
                      elevation: 2.0,
                      fillColor: badgeBackgroundColor,
                      child: badge,
                      constraints: badgeConstraints,
                      padding: badgePadding,
                      shape: CircleBorder(),
                    ),
                  )),
          ],
        ),
      ),
    );
  }
}
