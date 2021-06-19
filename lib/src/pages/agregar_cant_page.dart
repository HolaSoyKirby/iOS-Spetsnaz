import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class AgregarCantPage extends StatefulWidget {
  var _ing;

  AgregarCantPage(ing) {
    _ing = ing;
  }

  @override
  createState() {
    return AgregarCantPageState(_ing);
  }
}

class AgregarCantPageState extends State<AgregarCantPage> {
  String _id;

  AgregarCantPageState(var ing) {
    print('ASDSADASDASD');
    print(ing);
  }

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
  Widget build(BuildContext context) {
    return (Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Container>[
      Container(
          margin: EdgeInsets.only(top: 100, bottom: 20),
          child: Text('Nombre Ingrediente',
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'sans-serif-medium',
                  color: Colors.black))),
      Container(
          height: MediaQuery.of(context).size.height * 0.20,
          child: Center(
              child: Text('5 kg restante',
                  style: TextStyle(fontSize: 25, color: Colors.black)))),
      Container(
          margin: EdgeInsets.only(left: 15),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Agregar Cantidad',
                style: TextStyle(
                    fontSize: 18, color: Color.fromARGB(255, 255, 0, 0)),
              ))),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Cantidad'))),
      Container(
          margin: EdgeInsets.only(top: 10),
          child: DropdownButton(
              hint: Text('Unidad de medida', style: TextStyle(fontSize: 18)),
              value: _valueChoose,
              items: _listaMedidas.map((e) {
                return DropdownMenuItem(child: Text(e), value: e);
              }).toList(),
              onChanged: (e) {
                setState(() {
                  _valueChoose = e;
                });
              })),
      Container(
          margin: EdgeInsets.only(top: 70, left: 30, right: 30, bottom: 30),
          height: 60,
          child: SizedBox.expand(
              child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 222, 0, 16)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  child: Text("Agregar",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontFamily: 'sans-serif-medium'))))),
    ]))));
  }
}
