import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../components/user_form.dart';

class RegisterPage extends StatelessWidget {
  @override
  build(context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Container>[
          /////////////// FORM ////////////////
          Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 80),
              child: Column(children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                        margin: EdgeInsets.only(top: 50, bottom: 45),
                        child: Padding(
                            padding: EdgeInsets.only(bottom: 15),
                            child: Text('Crear Cuenta',
                                style: TextStyle(
                                    fontSize: 30,
                                    fontFamily: 'sans-serif-medium',
                                    color: Colors.black))))),
                UserForm(),
              ])),

          ///////////// BUTTON /////////////
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.circular(10)))),
                      child: Text("Crear Cuenta",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontFamily: 'sans-serif-medium'))))),
          Container(
            child: RichText(
                text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: '¿Ya tiene una cuenta? ',
                    style: TextStyle(
                        fontSize: 22, color: Color.fromARGB(255, 68, 68, 68))),
                TextSpan(
                    text: 'Iniciar Sesión',
                    style: TextStyle(
                        fontSize: 22, color: Color.fromARGB(255, 222, 0, 16)),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.of(context).pop();
                      }),
              ],
            )),
          )
        ],
      ),
    ));
  }
}
