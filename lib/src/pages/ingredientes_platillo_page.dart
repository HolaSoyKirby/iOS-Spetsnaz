import 'package:ProyectoSpetsnaz/src/services/database.dart';
import 'package:flutter/material.dart';

class IngredientesPlatilloPage extends StatefulWidget {
  var _plat;
  IngredientesPlatilloPage(var plat) {
    _plat = plat;
  }

  @override
  createState() {
    return IngredientesPlatilloPageState(_plat);
  }
}

class IngredientesPlatilloPageState extends State<IngredientesPlatilloPage> {
  var _plat;
  String _nombrePlatillo;

  IngredientesPlatilloPageState(var plat) {
    _plat = plat;
    print(_plat);
    _nombrePlatillo = _plat['nombreP'];
  }

  void prepararPlatillo() async {
    var _almacen = [];
    var _ingsActualizados = [];

    for (final ing in _plat['ingredientes']) {
      final getIng = await Database.getIngrediente(ing['IdIng']);
      var _cantProcesada = ing['cantidad'];

      if (ing['uMedida'] == 'c') {
        _cantProcesada *= 15;
      } else if (ing['uMedida'] == 't') {
        _cantProcesada *= 250;
      } else if (ing['uMedida'] == 'Kg' || ing['uMedida'] == 'L') {
        _cantProcesada *= 1000;
      }

      final _ing = {
        'id': getIng['IdIng'],
        'cantActual': getIng['cantidad'],
        'cantProcesada': _cantProcesada
      };

      _almacen.add(_ing);
    }

    print('ALMACEN');
    print(_almacen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Container>[
        Container(
            margin: EdgeInsets.only(
                top: MediaQuery.of(context).size.height * 0.015),
            height: MediaQuery.of(context).size.height * 0.15,
            child: Center(
                child: Text(
              _nombrePlatillo,
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'sans-serif-medium',
                  color: Color.fromARGB(255, 0, 0, 0)),
            ))),
        Container(
          height: MediaQuery.of(context).size.height * 0.70,
          child: Column(
            children: <Widget>[
              Text('Ingredientes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              _lista()
            ],
          ),
        ),

        //////BUTTON//////
        Container(
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 30),
            height: 60,
            child: SizedBox.expand(
                child: ElevatedButton(
                    onPressed: () {
                      prepararPlatillo();
                      //Navigator.of(context).pop();
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 222, 0, 16)),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)))),
                    child: Text("Preparar Platillo",
                        style: TextStyle(
                            fontSize: 22,
                            color: Colors.white,
                            fontFamily: 'sans-serif-medium'))))),
      ]),
    );
  }

  Widget _lista() {
    return Expanded(
        child: Container(
            margin: EdgeInsets.zero,
            child: ListView(
              children: _listaImgs(),
            )));
  }

  List<Widget> _listaImgs() {
    final List<Widget> opciones = [];

    for (final ing in _plat['ingredientes']) {
      opciones.add(_cardt1(ing));
    }
    return opciones;
  }

  Widget _cardt1(var ingrediente) {
    return Container(
        margin: EdgeInsets.zero,
        child: ListTile(
          title: Text(
            '- ${ingrediente['cantidad']} ${ingrediente['uMedida']} ${ingrediente['nombreIng']}',
            style: TextStyle(fontSize: 20),
          ),
        ));
  }
}
