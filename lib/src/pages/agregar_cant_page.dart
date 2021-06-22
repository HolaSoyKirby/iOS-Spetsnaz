import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../services/database.dart';

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
  String _id, _nombreIng, _cantRestante, _textError = '';

  List<String> _listaMedidas;
  String _valueChoose;
  double _cantidad = 0;

  AgregarCantPageState(var ing) {
    print('ASDSADASDASD');
    print(ing);
    _id = ing['id'];
    _nombreIng = ing['ingrediente'];
    _cantRestante =
        '${ing['cantidad'].toStringAsFixed(ing['cantidad'].truncateToDouble() == ing['cantidad'] ? 0 : 1)} ${ing['uMedida']} restante';

    if (ing['uMedida'] == 'g' || ing['uMedida'] == 'Kg') {
      _listaMedidas = ['Gramos', 'Kilogramos'];
    } else {
      _listaMedidas = ['Mililitros', 'Litros'];
    }
  }

  updateIngrediente() async {
    setState(() {
      _textError = '';
    });

    if (_cantidad <= 0) {
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

    double _cantFinal = _cantidad;
    if (_valueChoose == 'Kilogramos' || _valueChoose == 'Litros') {
      _cantFinal *= 1000;
    }

    print('CANT FINAL');
    print(_cantFinal);
    try {
      final _ing = await Database.getIngrediente(_id);
      final int _cantFinalFinal = (_ing['cantidad'] + _cantFinal).round();
      final res = await Database.updateIngrediente(_id, _cantFinalFinal);
      if (res['status'] == 'OK') {
        Navigator.of(context).pop(() {
          setState(() {});
        });
      } else {
        setState(() {
          _textError = res['mensaje'];
        });
      }
    } catch (e) {
      setState(() {
        _textError = e.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Container>[
      Container(
          margin: EdgeInsets.only(top: 100, bottom: 20),
          child: Text(_nombreIng,
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'sans-serif-medium',
                  color: Colors.black))),
      Container(
          height: MediaQuery.of(context).size.height * 0.20,
          child: Center(
              child: Text(_cantRestante,
                  style: TextStyle(fontSize: 25, color: Colors.black)))),
      Container(
          margin: EdgeInsets.only(left: 15),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Agregar Cantidad',
                style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
              ))),
      Container(
          margin: EdgeInsets.symmetric(horizontal: 15),
          child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: 'Cantidad'),
              onChanged: (value) {
                if (double.tryParse(value) != null) {
                  _cantidad = double.parse(value);
                } else {
                  _cantidad = 0;
                }
                print(_cantidad);
              })),
      Container(
          margin: EdgeInsets.only(top: 30),
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
                print(_valueChoose);
              })),
      /////// ERROR TEXT /////////
      Container(
          margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          height: 50,
          child: Center(
              child: Text(_textError,
                  style: TextStyle(
                      fontSize: 18, color: Color.fromARGB(255, 255, 0, 0))))),
      Container(
          margin: EdgeInsets.only(top: 40, left: 30, right: 30, bottom: 30),
          height: 60,
          child: SizedBox.expand(
              child: ElevatedButton(
                  onPressed: () {
                    updateIngrediente();
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
