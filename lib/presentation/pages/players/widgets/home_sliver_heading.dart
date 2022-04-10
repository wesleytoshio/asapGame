import 'package:flutter/material.dart';

import '../../../themes/theme_const.dart';

class HomeSliverHeading extends SliverPersistentHeaderDelegate {
  final String title;

  HomeSliverHeading({required this.title});
  @override
  double get minExtent => kToolbarHeight;

  @override
  double get maxExtent => kToolbarHeight;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final porcent = shrinkOffset / 40;
    double scaleValue = (1 - porcent).clamp(0, 1);
    print(porcent);
    return Container(
      padding: const EdgeInsets.all(kDefaultPadding),
      color: scaleValue > 0.0
          ? Colors.transparent
          : Theme.of(context).colorScheme.primary,
      child: Text(
        title,
        style: Theme.of(context)
            .textTheme
            .subtitle2!
            .copyWith(fontWeight: FontWeight.bold),
      ),
    );
  }

  @override
  bool shouldRebuild(HomeSliverHeading oldDelegate) {
    return false;
  }
}
