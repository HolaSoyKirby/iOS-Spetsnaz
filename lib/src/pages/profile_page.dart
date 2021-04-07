import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  final _styles = {
    'userView': {
      'margin': const EdgeInsets.only(top: 30, bottom: 30),
    },
    'userImg': {'height': 200.00},
    'userName': {'text': TextStyle(fontSize: 38, color: Colors.black)},
    'exitButtonView': {
      'margin':
          const EdgeInsets.only(left: 30, right: 30, top: 250, bottom: 30),
      'height': 60.00,
      'backgroundColor':
          MaterialStateProperty.all<Color>(Color.fromARGB(255, 222, 0, 16)),
      'borderRadius': MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
    },
    'exitText': {
      'text': TextStyle(
          fontSize: 22, color: Colors.white, fontFamily: 'sans-serif-medium')
    }
  };

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Column(
        children: <Container>[
          Container(
              margin: _styles['userView']['margin'],
              child: Column(children: <Widget>[
                Image.asset(
                  'assets/user.png',
                  height: _styles['userImg']['height'],
                ),
                Text('John Doe', style: _styles['userName']['text']),
              ])),
          Container(),
          Container(
              margin: _styles['exitButtonView']['margin'],
              height: _styles['exitButtonView']['height'],
              child: SizedBox.expand(
                  child: ElevatedButton(
                      onPressed: () {
                        while (Navigator.of(context).canPop()) {
                          // Navigator.canPop return true if can pop
                          Navigator.of(context).pop();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: _styles['exitButtonView']
                              ['backgroundColor'],
                          shape: _styles['exitButtonView']['borderRadius']),
                      child: Text("Cerrar Sesión",
                          style: _styles['exitText']['text']))))
        ],
      ),
    ));
  }
}
