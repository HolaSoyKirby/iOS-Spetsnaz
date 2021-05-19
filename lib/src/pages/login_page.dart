import 'package:flutter/material.dart';
import '../components/user_form.dart';

class LoginPage extends StatelessWidget {
  @override
  build(context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Container>[
      /////////////// LOGO ////////////////
      Container(
          margin: EdgeInsets.only(top: 30, bottom: 30),
          child: Column(children: <Widget>[
            Image.asset(
              'assets/Logo.png',
              height: 150,
            ),
            Text('Restaurante',
                style: TextStyle(
                    fontSize: 24,
                    fontFamily: 'sans-serif',
                    color: Color.fromARGB(255, 102, 102, 102))),
          ])),

      /////////////// FORM ////////////////
      Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          child: Column(children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                    padding: EdgeInsets.only(bottom: 15),
                    child: Text('Ingresar',
                        style: TextStyle(
                            fontSize: 20,
                            fontFamily: 'sans-serif-medium',
                            color: Colors.black)))),
            UserForm(),
          ])),

      ////////////// BUTTON //////////////
      Container(
          margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
          height: 60,
          child: SizedBox.expand(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/menuPage');
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 222, 0, 16)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  child: Text("Ingresar",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontFamily: 'sans-serif-medium'))))),
      Container(
          child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/registerPage');
              },
              child: Text('Registrarse',
                  style: TextStyle(
                      fontSize: 22, color: Color.fromARGB(255, 222, 0, 16)))))
    ])));
  }
}
