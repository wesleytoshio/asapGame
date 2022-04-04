import 'package:flutter/material.dart';

class NoPage extends StatefulWidget {
  const NoPage({Key? key}) : super(key: key);

  @override
  State<NoPage> createState() => _NoPageState();
}

class _NoPageState extends State<NoPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Page Not found'),
      ),
    );
  }
}
