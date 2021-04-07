import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../components/user_form.dart';
import '../components/menu_drawer.dart';

class RegisterPage extends StatelessWidget {
  final _styles = {
    /////////////// FORM ////////////////
    'formView': {
      'margin': const EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 80)
    },
    'registrarseText': {
      'alignment': Alignment.centerLeft,
      'text': TextStyle(
          fontSize: 30, fontFamily: 'sans-serif-medium', color: Colors.black),
      'margin': const EdgeInsets.only(top: 50, bottom: 45),
      'padding': const EdgeInsets.only(bottom: 15)
    },

    ///////////// BUTTON /////////////
    'registerButtonView': {
      'margin': const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      'height': 60.00,
      'backgroundColor':
          MaterialStateProperty.all<Color>(Color.fromARGB(255, 222, 0, 16)),
      'borderRadius': MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
    },
    'registerText': {
      'text': TextStyle(
          fontSize: 22, color: Colors.white, fontFamily: 'sans-serif-medium')
    },
    'loginAdviceText': {
      'text': TextStyle(fontSize: 22, color: Color.fromARGB(255, 68, 68, 68))
    },
    'loginText': {
      'text': TextStyle(fontSize: 22, color: Color.fromARGB(255, 222, 0, 16))
    }
  };
  @override
  build(context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Container>[
          /////////////// FORM ////////////////
          Container(
              margin: _styles['formView']['margin'],
              child: Column(children: <Widget>[
                Align(
                    alignment: _styles['registrarseText']['alignment'],
                    child: Container(
                        margin: _styles['registrarseText']['margin'],
                        child: Padding(
                            padding: _styles['registrarseText']['padding'],
                            child: Text(
                              'Crear Cuenta',
                              style: _styles['registrarseText']['text'],
                            )))),
                UserForm(),
              ])),

          ///////////// BUTTON /////////////
          Container(
              margin: _styles['registerButtonView']['margin'],
              height: _styles['registerButtonView']['height'],
              child: SizedBox.expand(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed('/menuPage');
                      },
                      style: ButtonStyle(
                        backgroundColor: _styles['registerButtonView']
                            ['backgroundColor'],
                        shape: _styles['registerButtonView']['borderRadius'],
                      ),
                      child: Text("Crear Cuenta",
                          style: _styles['registerText']['text'])))),
          Container(
            child: RichText(
                text: TextSpan(
              children: <TextSpan>[
                TextSpan(
                    text: '¿Ya tiene una cuenta? ',
                    style: _styles['loginAdviceText']['text']),
                TextSpan(
                    text: 'Iniciar Sesión',
                    style: _styles['loginText']['text'],
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
