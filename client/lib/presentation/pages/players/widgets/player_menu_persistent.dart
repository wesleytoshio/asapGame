import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

import '../../../themes/theme_const.dart';

class SliverPlayerMenuPersistent extends SliverPersistentHeaderDelegate {
  @override
  double get minExtent => 100;

  @override
  double get maxExtent => 100;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return SafeArea(
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        shape:
            ContinuousRectangleBorder(borderRadius: BorderRadius.circular(35)),
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
    );
  }

  @override
  bool shouldRebuild(SliverPlayerMenuPersistent oldDelegate) {
    return false;
  }
}
