import 'package:asap_game/presentation/themes/theme_const.dart';
import 'package:flutter/material.dart';

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
              child: Card(
                margin: const EdgeInsets.all(kDefaultPadding),
                child: Padding(
                  padding: const EdgeInsets.all(kDefaultPadding),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text.rich(
                              TextSpan(
                                text:
                                    'Você está convidado a desafiar com Soraia em ',
                                children: [
                                  TextSpan(
                                    text: 'Space Analysis',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.amber,
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
              ),
            ),
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
