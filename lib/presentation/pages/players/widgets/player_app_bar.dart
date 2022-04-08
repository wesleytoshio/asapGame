import 'package:asap_game/di/injectable.dart';
import 'package:asap_game/presentation/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../app_config.dart';
import '../../../widgets/animations/boucing.dart';

class PlayerSliveAppBarFlexible extends StatelessWidget {
  final double appBarHeight = 200;

  const PlayerSliveAppBarFlexible({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController appController = getIt<AppController>();
    return Builder(builder: (context) {
      return SliverAppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarIconBrightness: Brightness.dark,
        ),
        expandedHeight: appBarHeight,
        flexibleSpace: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
          double percent = ((constraints.maxHeight) / appBarHeight);
          var opactyValue = percent.clamp(0, 1).toDouble();

          return Transform.scale(
            scale: opactyValue,
            child: Opacity(
              opacity: opactyValue,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: kToolbarHeight),
                  Center(
                    child: SizedBox(
                      width: 130,
                      height: 130,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CustomCircleAvatar(
                              imagePath: appController.user!.picture!),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  bottom: 12.5, right: 12.5),
                              child: Bouncing(
                                onPressed: () async {
                                  await appController.loggedOut();
                                  AppConfig.instance.appRouter
                                      .replaceNamed('/login');
                                },
                                child: CircleAvatar(
                                  backgroundColor: Colors.white,
                                  radius: 16,
                                  child: Icon(Ionicons.settings_sharp),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Text(appController.user!.name!,
                      style: Theme.of(context).textTheme.headline6),
                  const SizedBox(height: 5),
                  Text('Level 16', style: Theme.of(context).textTheme.subtitle2)
                ],
              ),
            ),
          );
        }),
      );
    });
  }
}

class CustomCircleAvatar extends StatelessWidget {
  final String? imagePath;
  const CustomCircleAvatar({
    Key? key,
    this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 55,
        child: CircleAvatar(
          backgroundImage: NetworkImage(imagePath!),
          radius: 50,
        ),
      ),
    );
  }
}
