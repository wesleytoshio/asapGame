import 'package:asap_game/app_config.dart';
import 'package:asap_game/domain/entities/user_entity.dart';
import 'package:asap_game/presentation/pages/players/widgets/user_info_persistent.dart';
import 'package:asap_game/presentation/themes/theme_const.dart';
import 'package:breathing_collection/breathing_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ionicons/ionicons.dart';

import '../../widgets/animations/boucing.dart';
import '../../widgets/avatars/circle_avatar_with_badge.dart';

class PlayersPage extends StatelessWidget {
  const PlayersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final currentIndex = 0;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.grey[200],
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        // extendBodyBehindAppBar: true,
        // backgroundColor: Colors.black87,
        extendBody: true,
        body: Stack(
          children: [
            BreathingBackground(
              initialMainColor: Colors.white,
              transformedMainColor: Colors.grey[200],
              initialSecondaryColor: Colors.grey[200],
              transformedSecondaryColor: Colors.grey[300],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              duration: Duration(seconds: 3),
            ),
            CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // PlayerSliveAppBarFlexible(),
                // SliverPersistentHeader(
                //   delegate: SliverPlayerMenuPersistent(),
                //   floating: true,
                //   pinned: true,
                // ),
                SliverPersistentHeader(delegate: UserInfoPersistent()),
                SliverHeading(
                  title: 'CONVIDADO PARA JOGOS',
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  InvitationPending(),
                  InvitationPending(),
                ])),
                SliverHeading(
                  title: 'AMIGOS PARA DESAFIAR',
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  FriendsToPlay(
                    user: UserEntity(
                        name: 'Leonardo Medeiros',
                        picture: 'https://i.pravatar.cc/150?img=50'),
                  ),
                  FriendsToPlay(
                    user: UserEntity(
                        name: 'Mariana',
                        picture: 'https://i.pravatar.cc/150?img=5'),
                  ),
                  FriendsToPlay(
                    user: UserEntity(
                        name: 'Emmanuel',
                        picture: 'https://i.pravatar.cc/150?img=8'),
                  ),
                  FriendsToPlay(
                    user: UserEntity(
                        name: 'Eduardo',
                        picture: 'https://i.pravatar.cc/150?img=14'),
                  ),
                ])),
                SliverToBoxAdapter(
                  child: Container(
                    height: 400,
                  ),
                ),
              ],
            ),
          ],
        ),
        bottomNavigationBar: Card(
          margin:
              EdgeInsets.symmetric(vertical: 10, horizontal: kDefaultPadding),
          clipBehavior: Clip.hardEdge,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          child: BottomNavigationBar(
            showSelectedLabels: false,
            showUnselectedLabels: false,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Ionicons.home_outline),
                activeIcon: Icon(Ionicons.home),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.trophy_outline),
                activeIcon: Icon(Ionicons.trophy),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.people_outline),
                activeIcon: Icon(Ionicons.people),
                label: "",
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.notifications_outline),
                activeIcon: Icon(Ionicons.notifications),
                label: "",
              ),
            ],
            currentIndex: 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white,
            type: BottomNavigationBarType.fixed,
            onTap: (v) {},
          ),
        ),
      ),
    );
  }
}

class SliverHeading extends StatelessWidget {
  final String title;
  const SliverHeading({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Text(title, style: Theme.of(context).textTheme.caption),
      ),
    );
  }
}

class InvitationPending extends StatelessWidget {
  const InvitationPending({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onPressed: () {},
      child: Card(
        margin: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: 5),
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: InkWell(
          onTap: () => AppConfig.instance.appRouter.pushNamed('/game/1'),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'Você foi convidado a para jogar ',
                          children: [
                            TextSpan(
                              text: '"De quem é a famosa frase".',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: '🏆',
                            ),
                            TextSpan(
                              text: ' 350 pontos ao vencedor!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber[900],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: kDefaultPadding,
                ),
                Row(
                  children: [
                    Text('🕹️ Múltipla escolha'),
                    Spacer(),
                    Text('⏱️ Inicia em: 30 min'),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FriendsToPlay extends StatelessWidget {
  final UserEntity user;
  const FriendsToPlay({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onPressed: () {},
      child: Card(
        margin: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: 5),
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(25)),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding, vertical: 10),
          child: Row(
            children: [
              PlayerAvatarBadge(
                user: user,
                badge: Center(
                  child: Text(
                    "16",
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(user.name!),
                ),
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    "JOGAR",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

class PlayerAvatarBadge extends StatelessWidget {
  final Widget? badge;
  const PlayerAvatarBadge({
    Key? key,
    required this.user,
    this.badge,
  }) : super(key: key);

  final UserEntity user;

  @override
  Widget build(BuildContext context) {
    return CircleAvatarWithBadge(
      size: 50,
      badgeScale: 1,
      backgroundColor: Colors.white,
      backgroundImage: NetworkImage(user.picture!),
      borderOffset: .9,
      position: Offset(-17, -17),
      badgeElevation: 0,
      badgeConstraints: BoxConstraints(minHeight: 25, minWidth: 25),
      badgeBackgroundColor: Colors.white,
      badge: badge,
      badgePadding: EdgeInsets.zero,
      onPressedBadge: () {},
    );
  }
}
