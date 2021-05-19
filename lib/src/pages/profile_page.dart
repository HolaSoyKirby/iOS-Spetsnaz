import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  @override
  createState() {
    return ProfilePageState();
  }
}

class ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return (Scaffold(
      body: Column(
        children: <Container>[
          Container(
              margin: EdgeInsets.only(top: 30, bottom: 30),
              child: Column(children: <Widget>[
                Image.asset(
                  'assets/user.png',
                  height: 200,
                ),
                Text('John Doe',
                    style: TextStyle(fontSize: 38, color: Colors.black)),
              ])),
          Container(),
          Container(
              margin:
                  EdgeInsets.only(left: 30, right: 30, top: 250, bottom: 30),
              height: 60,
              child: SizedBox.expand(
                  child: ElevatedButton(
                      onPressed: () {
                        while (Navigator.of(context).canPop()) {
                          // Navigator.canPop return true if can pop
                          Navigator.of(context).pop();
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color.fromARGB(255, 222, 0, 16)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                      child: Text("Cerrar Sesión",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontFamily: 'sans-serif-medium')))))
        ],
      ),
    ));
  }
}
