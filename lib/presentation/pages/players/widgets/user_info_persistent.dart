import 'package:flutter/material.dart';

import '../../../../di/injectable.dart';
import '../../../app/app_controller.dart';
import '../../../themes/theme_const.dart';
import '../../../widgets/avatars/circle_avatar_with_badge.dart';

const _minExtent = 100.0;
const _maxExtent = 230.0;

const _minPointsTranslateX = 0;
const _maxPointsTranslateX = 100;

class UserInfoPersistent extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => _minExtent;

  @override
  double get maxExtent => _maxExtent;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final porcent = shrinkOffset / _maxExtent;
    double scaleValue = (1 - porcent).clamp(0, 1);
    AppController appController = getIt<AppController>();
    return Padding(
      padding: const EdgeInsets.only(top: kDefaultPadding),
      child: Opacity(
        opacity: scaleValue < 0.5 ? scaleValue : 1,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Transform.translate(
              offset: Offset(-_maxPointsTranslateX * porcent, 0),
              child: UserInfoPersistentLabel(
                crossAxisAlignment: CrossAxisAlignment.end,
                title: '347',
                subTitle: 'PONTOS',
              ),
            ),
            Transform.scale(
              scale: scaleValue,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatarWithBadge(
                      size: 100,
                      scale: 1,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                      backgroundImage:
                          NetworkImage(appController.user!.picture!),
                      borderOffset: .9,
                      position: Offset(-7, -7),
                      badgeConstraints:
                          BoxConstraints(minHeight: 30, minWidth: 30),
                      badgeBackgroundColor:
                          Theme.of(context).colorScheme.primary,
                      badge: Center(
                        child: Text(
                          "99",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      badgePadding: const EdgeInsets.all(2),
                      onPressedBadge: () {},
                    ),
                    const SizedBox(height: 10),
                    Text(
                      appController.user!.name!,
                      style: Theme.of(context).textTheme.headline6,
                    )
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(_maxPointsTranslateX * porcent, 0),
              child: UserInfoPersistentLabel(
                crossAxisAlignment: CrossAxisAlignment.start,
                title: '14º',
                subTitle: 'RANKING',
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(UserInfoPersistent oldDelegate) {
    return false;
  }
}

class UserInfoPersistentLabel extends StatelessWidget {
  final CrossAxisAlignment crossAxisAlignment;
  final String title;
  final String subTitle;
  const UserInfoPersistentLabel({
    Key? key,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    required this.title,
    required this.subTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: crossAxisAlignment,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.caption,
        )
      ],
    );
  }
}
