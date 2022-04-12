import 'package:asap_game/infra/utils/color_utils.dart';
import 'package:asap_game/presentation/widgets/clippers/wave_clipper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../app_config.dart';
import '../../../../di/injectable.dart';
import '../../../app/app_controller.dart';
import '../../../themes/theme_const.dart';
import '../../../widgets/animations/boucing.dart';
import '../../../widgets/avatars/circle_avatar_with_badge.dart';

const _minExtent = 100.0;
const _maxExtent = 250.0;

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
    double _clipperDistance = 30 * (1 - porcent).clamp(0, 30);
    AppController appController = getIt<AppController>();
    return ClipPath(
      clipper: OvalBottomBorderClipper(distance: _clipperDistance),
      child: Container(
        color: Theme.of(context).colorScheme.primary,
        padding: const EdgeInsets.only(top: kDefaultPadding),
        child: Opacity(
          opacity: scaleValue < 0.5 ? scaleValue : 1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Transform.translate(
                offset: Offset(-_maxPointsTranslateX * porcent, 0),
                child: const UserInfoPersistentLabel(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  title: '347',
                  subTitle: 'PONTOS',
                ),
              ),
              Transform.scale(
                scale: scaleValue,
                child: Bouncing(
                  onPressed: () async {
                    await appController.loggedOut();
                    AppConfig.instance.appRouter.replaceNamed('/login');
                  },
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5),
                          child: SvgPicture.asset(
                            'assets/svg/grupo_smart_fit.svg',
                            height: 38,
                          ),
                        ),
                        CircleAvatarWithBadge(
                          size: 90,
                          scale: 1,
                          backgroundColor:
                              ColorUtils.primaryColorLuminance(context)
                                  .withOpacity(0.2),
                          backgroundImage:
                              NetworkImage(appController.user!.picture!),
                          borderOffset: .9,
                          position: const Offset(-8, -8),
                          badgeConstraints:
                              const BoxConstraints(minHeight: 30, minWidth: 30),
                          badgeBackgroundColor:
                              Theme.of(context).colorScheme.primary,
                          badgeElevation: 0,
                          badge: const Center(
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
                        Text(appController.user!.name!,
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1!
                                .copyWith(
                                  color:
                                      ColorUtils.primaryColorLuminance(context),
                                ))
                      ],
                    ),
                  ),
                ),
              ),
              Transform.translate(
                offset: Offset(_maxPointsTranslateX * porcent, 0),
                child: const UserInfoPersistentLabel(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  title: '14º',
                  subTitle: 'RANKING',
                ),
              ),
            ],
          ),
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
                color: ColorUtils.primaryColorLuminance(context),
              ),
        ),
        Text(
          subTitle,
          style: Theme.of(context).textTheme.caption!.copyWith(
              color: ColorUtils.primaryColorLuminance(context).withAlpha(130)),
        )
      ],
    );
  }
}
