import 'package:ProyectoSpetsnaz/src/services/database.dart';
import 'package:flutter/material.dart';

class AgregarIngPage extends StatefulWidget {
  @override
  createState() {
    return AgregarIngPageState();
  }
}

class AgregarIngPageState extends State<AgregarIngPage> {
  String _nombreIng = '', _textError = '';
  double _cant = 0;

  final List<String> _listaMedidas = [
    'Gramos',
    'Kilogramos',
    'Mililitros',
    'Litros'
  ];

  String _valueChoose;

  crearIngrediente() async {
    setState(() {
      _textError = '';
    });

    if (_nombreIng == '') {
      setState(() {
        _textError = 'Ingrese el nombre del ingrediente';
      });
      return;
    }

    if (_cant <= 0) {
      setState(() {
        _textError = 'Ingrese una cantidad válida';
      });
      return;
    }

    if (_valueChoose == null) {
      setState(() {
        _textError = 'Ingrese una unidad de medida';
      });
      return;
    }

    String _uMedida;
    double _cantFinal = _cant;

    if (_valueChoose == 'Kilogramos' || _valueChoose == 'Litros') {
      _cantFinal *= 1000;
    }

    if (_valueChoose == 'Kilogramos' || _valueChoose == 'Gramos') {
      _uMedida = 'g';
    } else {
      _uMedida = 'ml';
    }

    final res =
        await Database.postIngrediente(_nombreIng, _cantFinal, _uMedida);
    if (res['status'] == 'OK') {
      Navigator.of(context).pop(() {
        setState(() {});
      });
    } else {
      setState(() {
        _textError = res['mensaje'];
      });
    }
  }

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
                                contentPadding: EdgeInsets.only(bottom: -10)),
                            onChanged: (value) {
                              _nombreIng = value;
                              print(_nombreIng);
                            }),
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
                            keyboardType: TextInputType.number,
                            enableSuggestions: false,
                            autocorrect: false,
                            onChanged: (value) {
                              if (double.tryParse(value) != null) {
                                _cant = double.parse(value);
                              } else {
                                _cant = 0;
                              }
                              print(_cant);
                            })
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
                      margin: EdgeInsets.only(bottom: 40),
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
                            print(_valueChoose);
                          })),
                  /////// ERROR TEXT /////////
                  Container(
                      margin: EdgeInsets.only(left: 20, right: 20, bottom: 55),
                      height: 50,
                      child: Center(
                          child: Text(_textError,
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromARGB(255, 255, 0, 0))))),
                  /////////////BUTTON////////////
                  Container(
                      margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
                      height: 60,
                      child: SizedBox.expand(
                          child: ElevatedButton(
                              onPressed: () {
                                //Navigator.of(context).pop();
                                crearIngrediente();
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
