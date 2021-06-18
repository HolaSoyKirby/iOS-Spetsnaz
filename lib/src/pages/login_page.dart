import 'package:flutter/material.dart';
import '../services/autenticacion.dart';

class LoginPage extends StatefulWidget {
  @override
  createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  String _email = '', _password = '', _textError = '';

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
        margin: EdgeInsets.only(left: 20, right: 20, bottom: 5),
        child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(bottom: 15),
                child: Text('Ingresar',
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'sans-serif-medium',
                        color: Colors.black)))),
      ),
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
                }),
          ],
        ),
      ),
      Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
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
              onChanged: (value) {
                _password = value;
                print(_password);
              },
            )
          ])),

/////// ERROR TEXT /////////
      Container(
          margin: EdgeInsets.only(left: 20, right: 20, bottom: 20),
          height: 50,
          child: Center(
              child: Text(_textError,
                  style: TextStyle(
                      fontSize: 18, color: Color.fromARGB(255, 255, 0, 0))))),

      ////////////// BUTTON //////////////
      Container(
          margin: EdgeInsets.only(left: 30, right: 30, bottom: 15),
          height: 60,
          child: SizedBox.expand(
              child: ElevatedButton(
                  onPressed: () {
                    iniciarSesion(context);
                    //Navigator.of(context).pushNamed('/menuPage');
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

  void iniciarSesion(BuildContext context) async {
    setState(() {
      _textError = '';
    });
    final res = await Autenticacion.singIn(_email, _password);
    if (res['status'] == 'ERROR') {
      setState(() {
        _textError = res['mensaje'];
      });
    } else {
      Navigator.of(context).pushNamed('/menuPage', arguments: res['mensaje']);
    }
  }
}
