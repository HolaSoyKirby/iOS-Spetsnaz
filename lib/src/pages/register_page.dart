import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../services/autenticacion.dart';

class RegisterPage extends StatefulWidget {
  @override
  createState() {
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  String _email = '', _password = '', _textError = '';

  @override
  build(context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Container>[
          /////////////// FORM ////////////////
          Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 80),
              child: Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                      margin: EdgeInsets.only(
                        top: 50,
                      ),
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 15),
                          child: Text('Crear Cuenta',
                              style: TextStyle(
                                  fontSize: 30,
                                  fontFamily: 'sans-serif-medium',
                                  color: Colors.black)))))),

          Container(
            margin: EdgeInsets.only(left: 20, right: 20, bottom: 15),
            child: Column(
              children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Usuario',
                        style: TextStyle(
                          fontSize: 18,
                          fontFamily: 'sans-serif',
                          color: Color.fromARGB(255, 222, 0, 16),
                        ))),
                TextField(
                  style: TextStyle(fontSize: 18),
                  decoration: InputDecoration(
                      hintText: 'Tu usuario',
                      contentPadding: EdgeInsets.only(bottom: -10)),
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    _email = value;
                    print(_email);
                  },
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
              child: Column(children: <Widget>[
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Contraseña',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: 'sans-serif',
                        color: Color.fromARGB(255, 222, 0, 16),
                      ),
                    )),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Contraseña',
                    contentPadding: EdgeInsets.only(bottom: -10),
                  ),
                  style: TextStyle(fontSize: 18),
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.visiblePassword,
                  onChanged: (value) {
                    _password = value;
                    print(_password);
                  },
                )
              ])),

/////// ERROR TEXT /////////
          Container(
              margin: EdgeInsets.only(left: 20, right: 20, bottom: 25),
              height: 50,
              child: Text(_textError,
                  style: TextStyle(
                      fontSize: 18, color: Color.fromARGB(255, 255, 0, 0)))),

          ///////////// BUTTON /////////////
          Container(
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
              height: 60,
              child: SizedBox.expand(
                  child: ElevatedButton(
                      onPressed: () {
                        registrarse(context);
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

  void registrarse(BuildContext context) async {
    setState(() {
      _textError = '';
    });
    final res = await Autenticacion.signUp(_email, _password);
    if (res['status'] == 'ERROR') {
      setState(() {
        _textError = res['mensaje'];
      });
    } else {
      Navigator.of(context).pushNamed('/menuPage', arguments: res['mensaje']);
    }
  }
}
