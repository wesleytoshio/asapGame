import 'package:flutter/material.dart';

import 'widgets/player_app_bar.dart';

class PlayersPage extends StatelessWidget {
  const PlayersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PlayerAppBar(),
    );
  }
}
