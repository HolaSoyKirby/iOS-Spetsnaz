import 'package:flutter/material.dart';

class UserForm extends StatefulWidget {
  @override
  createState() {
    return UserFormState();
  }
}

class UserFormState extends State<UserForm> {
  final _styles = {
    'formText': {
      'margin': const EdgeInsets.only(bottom: 30),
      'text': TextStyle(
        fontSize: 18,
        fontFamily: 'sans-serif',
        color: Color.fromARGB(255, 222, 0, 16),
      ),
      'alignment': Alignment.centerLeft
    },
    'formTextInput': {
      'text': TextStyle(fontSize: 18),
      'margin': EdgeInsets.only(bottom: -10),
      'alignment': Alignment.centerLeft
    }
  };

  @override
  Widget build(context) {
    return Container(
        child: Align(
      alignment: _styles['formText']['alignment'],
      child: Column(children: <Container>[
        Container(
          margin: _styles['formText']['margin'],
          child: Column(
            children: <Widget>[
              Align(
                  alignment: _styles['formTextInput']['alignment'],
                  child: Text('Usuario', style: _styles['formText']['text'])),
              TextField(
                  style: _styles['formTextInput']['text'],
                  decoration: InputDecoration(
                      hintText: 'Tu usuario',
                      contentPadding: _styles['formTextInput']['margin'])),
            ],
          ),
        ),
        Container(
            margin: _styles['formText']['margin'],
            child: Column(children: <Widget>[
              Align(
                  alignment: _styles['formText']['alignment'],
                  child: Text(
                    'Contraseña',
                    style: _styles['formText']['text'],
                  )),
              TextField(
                decoration: new InputDecoration(
                  hintText: 'Contraseña',
                  contentPadding: _styles['formTextInput']['margin'],
                ),
                style: _styles['formTextInput']['text'],
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              )
            ])),
      ]),
    ));
  }
}
