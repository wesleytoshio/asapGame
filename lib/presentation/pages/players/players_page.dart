import 'package:asap_game/domain/entities/user_entity.dart';
import 'package:asap_game/presentation/themes/theme_const.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import 'widgets/player_app_bar.dart';

class PlayersPage extends StatelessWidget {
  const PlayersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.primary,
            ],
          ),
        ),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            PlayerSliveAppBarFlexible(),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(35)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton.icon(
                          onPressed: () {},
                          icon: Icon(
                            Ionicons.people_sharp,
                            size: 20,
                          ),
                          label: Text(
                            'Amigos',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: null,
                          icon: Icon(
                            Ionicons.pulse_outline,
                            size: 20,
                          ),
                          label: Text(
                            'Estatisticas',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: null,
                          icon: Icon(
                            Ionicons.extension_puzzle_outline,
                            size: 20,
                          ),
                          label: Text(
                            'Jogos',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SliverHeading(
              title: 'QUEREM JOGAR COM VOCÊ',
            ),
            SliverToBoxAdapter(
              child: InvitationPending(),
            ),
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
                    name: 'Loana', picture: 'https://i.pravatar.cc/150?img=5'),
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
                height: 800,
              ),
            )
          ],
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
              .caption!
              .copyWith(color: Colors.white),
        ),
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
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text.rich(
                    TextSpan(
                      text: 'Você está convidado a desafiar com Soraia em ',
                      children: [
                        TextSpan(
                          text: 'Space Analysis',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.amber[900],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                ClipOval(
                  child: Image.network(
                    'https://i.pravatar.cc/150?img=24',
                    fit: BoxFit.cover,
                    width: 40,
                    height: 40,
                  ),
                )
              ],
            ),
            Divider(
              height: kDefaultPadding,
            ),
            Text('350 pontos bonus ao vencedor jogo!')
          ],
        ),
      ),
    );
  }
}

class FriendsToPlay extends StatelessWidget {
  final UserEntity? user;
  const FriendsToPlay({
    Key? key,
    this.user,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin:
          const EdgeInsets.symmetric(horizontal: kDefaultPadding, vertical: 5),
      shape: ContinuousRectangleBorder(borderRadius: BorderRadius.circular(25)),
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: kDefaultPadding, vertical: 5),
        child: Column(
          children: [
            Row(
              children: [
                SizedBox(
                  height: 40,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      ClipOval(
                        child: Image.network(
                          user!.picture!,
                          fit: BoxFit.cover,
                          width: 40,
                          height: 40,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Transform.scale(
                          scale: 0.8,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            decoration: BoxDecoration(
                              color: Colors.amber[900],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              '300P',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(user!.name!),
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
          ],
        ),
      ),
    );
  }
}
