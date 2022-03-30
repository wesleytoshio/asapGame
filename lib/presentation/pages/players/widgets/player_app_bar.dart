import 'package:flutter/material.dart';

class PlayerAppBar extends StatefulWidget implements PreferredSizeWidget {
  const PlayerAppBar({Key? key})
      : preferredSize = const Size.fromHeight(60.0),
        super(key: key);

  @override
  final Size preferredSize;

  @override
  _CustomAppBarState createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<PlayerAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: <Widget>[
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.logout,
          ),
        ),
      ],
    );
  }
}
