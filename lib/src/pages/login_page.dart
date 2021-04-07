import 'package:flutter/material.dart';
import '../components/user_form.dart';
import './register_page.dart';
import '../components/menu_drawer.dart';

class LoginPage extends StatelessWidget {
  final _styles = {
    /////////////// LOGO ////////////////
    'logoView': {'margin': const EdgeInsets.only(top: 30, bottom: 30)},
    'logoImg': {'height': 150.00},
    'logoText': {
      'text': TextStyle(
          fontSize: 24,
          fontFamily: 'sans-serif',
          color: Color.fromARGB(255, 102, 102, 102))
    },

    /////////////// FORM ////////////////
    'formView': {
      'margin': const EdgeInsets.only(left: 20, right: 20, bottom: 20)
    },
    'ingresarText': {
      'alignment': Alignment.centerLeft,
      'margin': const EdgeInsets.only(bottom: 15),
      'text': TextStyle(
          fontSize: 20, fontFamily: 'sans-serif-medium', color: Colors.black)
    },

    ////////////// BUTTON //////////////
    'loginButtonView': {
      'height': 60.00,
      'margin': const EdgeInsets.only(left: 30, right: 30, bottom: 30),
      'backgroundColor':
          MaterialStateProperty.all<Color>(Color.fromARGB(255, 222, 0, 16)),
      'borderRadius': MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)))
    },
    'loginText': {
      'text': TextStyle(
          fontSize: 22, color: Colors.white, fontFamily: 'sans-serif-medium')
    },
    'registrarseText': {
      'text': TextStyle(fontSize: 22, color: Color.fromARGB(255, 222, 0, 16))
    }
  };

  @override
  build(context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Container>[
      /////////////// LOGO ////////////////
      Container(
          margin: _styles['logoView']['margin'],
          child: Column(children: <Widget>[
            Image.asset(
              'assets/Logo.png',
              height: _styles['logoImg']['height'],
            ),
            Text('Restaurante', style: _styles['logoText']['text']),
          ])),

      /////////////// FORM ////////////////
      Container(
          margin: _styles['formView']['margin'],
          child: Column(children: <Widget>[
            Align(
                alignment: _styles['ingresarText']['alignment'],
                child: Padding(
                    padding: _styles['ingresarText']['margin'],
                    child: Text(
                      'Ingresar',
                      style: _styles['ingresarText']['text'],
                    ))),
            UserForm(),
          ])),

      ////////////// BUTTON //////////////
      Container(
          margin: _styles['loginButtonView']['margin'],
          height: _styles['loginButtonView']['height'],
          child: SizedBox.expand(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushNamed('/menuPage');
                  },
                  style: ButtonStyle(
                      backgroundColor: _styles['loginButtonView']
                          ['backgroundColor'],
                      shape: _styles['loginButtonView']['borderRadius']),
                  child:
                      Text("Ingresar", style: _styles['loginText']['text'])))),
      Container(
          child: TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/registerPage');
              },
              child: Text('Registrarse',
                  style: _styles['registrarseText']['text'])))
    ])));
  }
}
