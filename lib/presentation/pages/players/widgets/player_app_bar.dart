import 'package:asap_game/di/injectable.dart';
import 'package:asap_game/presentation/app/app_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../app_config.dart';

class PlayerSliveAppBarFlexible extends StatelessWidget {
  final double appBarHeight = 140;

  const PlayerSliveAppBarFlexible({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AppController appController = getIt<AppController>();
    return Observer(builder: (context) {
      return SliverAppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        expandedHeight: 250,
        flexibleSpace: SafeArea(
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
                      Center(
                        child: CircleAvatar(
                          backgroundColor: Colors.white,
                          radius: 55,
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(appController.user!.picture!),
                            radius: 50,
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 12.5, right: 12.5),
                          child: GestureDetector(
                            onTap: () async {
                              await appController.loggedOut();
                              AppConfig.instance.appRouter
                                  .replaceNamed('/login');
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.white,
                              radius: 16,
                              child: Icon(Ionicons.settings_outline),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                appController.user!.name!,
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(color: Colors.white),
              ),
              const SizedBox(height: 5),
              Text(
                'Level 16',
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: Colors.white),
              )
            ],
          ),
        ),
      );
    });
  }
}
