import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgregarIngPage extends StatefulWidget {
  @override
  createState() {
    return AgregarIngPageState();
  }
}

class AgregarIngPageState extends State<AgregarIngPage> {
  final List<String> _listaMedidas = [
    'Gramos',
    'Cucharadas (sólidos)',
    'Tazas (sólidos)',
    'Kilogramos',
    'Mililitros',
    'Cucharadas (líquidos)',
    'Tazas (líquidos)',
    'Litros'
  ];

  String _valueChoose;

  @override
  Widget build(context) {
    return (Scaffold(
        body: SingleChildScrollView(
            child: Container(
                ////////// TITULO //////////
                margin:
                    EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 15),
                child: Column(children: <Container>[
                  Container(
                      margin: EdgeInsets.only(bottom: 80),
                      child: Text('Agregar Ingrediente',
                          style: TextStyle(
                              fontSize: 30,
                              fontFamily: 'sans-serif-medium',
                              color: Colors.black))),

                  ////////FORM INGREDIENTE///////
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: Column(
                      children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Ingrediente',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'sans-serif',
                                    color: Color.fromARGB(255, 222, 0, 16)))),
                        TextField(
                            style: TextStyle(fontSize: 18),
                            decoration: InputDecoration(
                                hintText: 'Ingrediente',
                                contentPadding: EdgeInsets.only(bottom: -10))),
                      ],
                    ),
                  ),
                  ////////FORM CANTIDAD///////
                  Container(
                      margin: EdgeInsets.only(bottom: 30),
                      child: Column(children: <Widget>[
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text('Cantidad',
                                style: TextStyle(
                                    fontSize: 18,
                                    fontFamily: 'sans-serif',
                                    color: Color.fromARGB(255, 222, 0, 16)))),
                        TextField(
                          decoration: new InputDecoration(
                              hintText: 'Cantidad',
                              contentPadding: EdgeInsets.only(bottom: -10)),
                          style: TextStyle(fontSize: 18),
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                        )
                      ])),

                  Container(
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Unidad de medida',
                          style: TextStyle(
                              fontSize: 18,
                              fontFamily: 'sans-serif',
                              color: Color.fromARGB(255, 222, 0, 16)),
                        )),
                  ),
                  ////////// PICKER ///////////
                  Container(
                      margin: EdgeInsets.only(bottom: 80),
                      child: DropdownButton(
                          hint: Text('Unidad de medida'),
                          value: _valueChoose,
                          items: _listaMedidas.map((e) {
                            return DropdownMenuItem(child: Text(e), value: e);
                          }).toList(),
                          onChanged: (e) {
                            setState(() {
                              _valueChoose = e;
                            });
                          })),

                  /////////////BUTTON////////////
                  Container(
                      margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                      height: 60,
                      child: SizedBox.expand(
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Color.fromARGB(255, 222, 0, 16)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)))),
                              child: Text("Agregar Ingrediente",
                                  style: TextStyle(
                                      fontSize: 22,
                                      color: Colors.white,
                                      fontFamily: 'sans-serif-medium')))))
                ])))));
  }
}
