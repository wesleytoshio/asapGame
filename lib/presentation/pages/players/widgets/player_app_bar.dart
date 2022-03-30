import 'package:flutter/material.dart';

class PlayerSliveAppBarFlexible extends StatelessWidget {
  final double appBarHeight = 140;

  const PlayerSliveAppBarFlexible({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      expandedHeight: 250,
      flexibleSpace: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: kToolbarHeight),
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 55,
              child: CircleAvatar(
                backgroundImage:
                    NetworkImage('https://i.pravatar.cc/150?img=22'),
                radius: 50,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Wesley Oliveira',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 5),
            Text(
              'Level 16',
              style: Theme.of(context).textTheme.subtitle2,
            )
          ],
        ),
      ),
    );
  }
}
