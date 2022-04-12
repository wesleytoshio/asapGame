import 'package:asap_game/app_config.dart';
import 'package:asap_game/domain/entities/user_entity.dart';
import 'package:asap_game/presentation/themes/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:ionicons/ionicons.dart';

import '../../../infra/utils/color_utils.dart';
import '../../widgets/animations/boucing.dart';
import '../../widgets/avatars/circle_avatar_with_badge.dart';
import 'widgets/user_info_persistent.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({Key? key}) : super(key: key);

  @override
  State<PlayersPage> createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  late ScrollController _scrollController;

  @override
  void initState() {
    _scrollController = ScrollController(initialScrollOffset: 0);
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        // resizeToAvoidBottomInset: false,
        // extendBodyBehindAppBar: true,
        backgroundColor: Colors.white,
        extendBody: true,
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          controller: _scrollController,
          slivers: [
            SliverPersistentHeader(
              delegate: UserInfoPersistent(),
            ),
            SliverStickyHeader.builder(
              builder: (context, state) => HeadingSticky(
                state: state,
                title: "Predator Gaming",
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => const InvitationPending(
                    picture:
                        "https://pbs.twimg.com/profile_images/1268864464838897664/yc3b7d9c_400x400.jpg",
                  ),
                  childCount: 4,
                ),
              ),
            ),
            SliverStickyHeader.builder(
              builder: (context, state) => HeadingSticky(
                state: state,
                title: "Maxima Gaming",
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => const InvitationPending(
                    picture:
                        "https://pbs.twimg.com/profile_images/1422322042741919755/-NgZPdSV_400x400.png",
                  ),
                  childCount: 4,
                ),
              ),
            ),
            SliverStickyHeader.builder(
              builder: (context, state) => HeadingSticky(
                state: state,
                title: "Nocturnos Gaming",
              ),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, i) => const InvitationPending(
                    picture:
                        "https://yt3.ggpht.com/-TB_iYWxtXUGMHWDYGDPgnafNFYdbpUkKtasjmD8Plb1KpcyNl6fEITgzsx2E3spVA77liXOz8I=s900-c-k-c0x00ffffff-no-rj",
                  ),
                  childCount: 4,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                height: 400,
              ),
            ),
          ],
        ),
        bottomNavigationBar: AnimatedBuilder(
            animation: _scrollController,
            builder: (context, child) {
              return AnimatedCrossFade(
                duration: const Duration(milliseconds: 300),
                crossFadeState: (_scrollController.hasClients &&
                        _scrollController.position.userScrollDirection ==
                            ScrollDirection.reverse)
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                secondChild: const SizedBox.shrink(),
                firstChild: Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 2, horizontal: kDefaultPadding),
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: BottomNavigationBar(
                    showSelectedLabels: false,
                    showUnselectedLabels: false,
                    selectedIconTheme: Theme.of(context).iconTheme.copyWith(
                          color: ColorUtils.primaryColorLuminance(context),
                        ),
                    unselectedIconTheme: Theme.of(context).iconTheme.copyWith(
                          color: ColorUtils.primaryColorLuminance(context),
                        ),
                    items: [
                      const BottomNavigationBarItem(
                        icon: Icon(Ionicons.home_outline),
                        activeIcon: Icon(Ionicons.home),
                        label: "",
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Ionicons.trophy_outline),
                        activeIcon: Icon(Ionicons.trophy),
                        label: "",
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Ionicons.people_outline),
                        activeIcon: Icon(Ionicons.people),
                        label: "",
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Ionicons.notifications_outline),
                        activeIcon: Icon(Ionicons.notifications),
                        label: "",
                      ),
                      const BottomNavigationBarItem(
                        icon: Icon(Ionicons.settings_outline),
                        activeIcon: Icon(Ionicons.settings),
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
              );
            }),
      ),
    );
  }
}

class HeadingSticky extends StatelessWidget {
  final SliverStickyHeaderState state;
  final String title;
  const HeadingSticky({
    Key? key,
    required this.state,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: state.isPinned ? 0.3 : 0,
      color: Colors.white,
      child: AnimatedPadding(
        padding: EdgeInsets.only(top: state.isPinned ? 35 : 0),
        duration: const Duration(milliseconds: 200),
        // color: (state.isPinned
        //         ? Theme.of(context).colorScheme.primary
        //         : Colors.white)
        //     .withOpacity(1.0 - state.scrollPercentage),
        child: Container(
          padding: const EdgeInsets.all(kDefaultPadding),
          child: Text(
            title,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                fontWeight: FontWeight.bold,
                color: state.isPinned
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black54),
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
        child: Text(
          title,
          style: Theme.of(context)
              .textTheme
              .subtitle2!
              .copyWith(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class InvitationPending extends StatelessWidget {
  final String picture;
  const InvitationPending({
    Key? key,
    required this.picture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onPressed: () {},
      child: Card(
        margin: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: 5),
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: const BorderSide(color: Colors.grey, width: 1),
        ),
        elevation: 0,
        child: InkWell(
          onTap: () => AppConfig.instance.appRouter.pushNamed('/game/1'),
          child: Padding(
            padding: const EdgeInsets.all(kDefaultPadding),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatarWithBadge(
                      size: 55,
                      scale: 1,
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .primary
                          .withOpacity(0.5),
                      backgroundImage: NetworkImage(picture),
                      borderOffset: .9,
                      position: const Offset(-13, -13),
                      badgeConstraints:
                          const BoxConstraints(minHeight: 20, minWidth: 20),
                      badgeBackgroundColor:
                          Theme.of(context).colorScheme.primary,
                      badge: const Center(
                        child: Text(
                          "10",
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
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          text: 'Você foi convidado a para jogar ',
                          children: [
                            const TextSpan(
                              text: '"De quem é a famosa frase".',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: '\n🪙',
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
                const Divider(
                  height: kDefaultPadding,
                ),
                Row(
                  children: [
                    const Text('🕹️ Múltipla escolha'),
                    const Spacer(),
                    const Text('⏱️ Inicia em: 30 min'),
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
                badge: const Center(
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
                  child: const Text(
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
      position: const Offset(-17, -17),
      badgeElevation: 0,
      badgeConstraints: const BoxConstraints(minHeight: 25, minWidth: 25),
      badgeBackgroundColor: Colors.white,
      badge: badge,
      badgePadding: EdgeInsets.zero,
      onPressedBadge: () {},
    );
  }
}
