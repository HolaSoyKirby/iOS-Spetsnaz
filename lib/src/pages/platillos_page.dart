import 'package:flutter/material.dart';

class PlatillosPage extends StatefulWidget {
  @override
  createState() {
    return PlatillosPageState();
  }
}

class PlatillosPageState extends State<PlatillosPage> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: Container(
            child: Column(children: <Widget>[
      Image.asset(
        'assets/Logo.png',
      ),
      Text('Platillos'),
    ]))));
  }
}
