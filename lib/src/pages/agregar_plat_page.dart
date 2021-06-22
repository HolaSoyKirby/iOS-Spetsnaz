import 'package:ProyectoSpetsnaz/src/pages/ingredientes_platillo_page.dart';
import 'package:ProyectoSpetsnaz/src/services/database.dart';
import 'package:flutter/material.dart';

class AgregarPlatPage extends StatefulWidget {
  @override
  createState() {
    return AgregarPlatPageState();
  }
}

class AgregarPlatPageState extends State<AgregarPlatPage> {
  String _textError = 'Error xdxdxdxdxdd';

  String _nombrePlatillo = '';
  var _ingredientesPlatillo = [];

  List<DropdownMenuItem<dynamic>> _ings = [];

  List<DropdownMenuItem<dynamic>> _opcionMedida = [];
  final List _medidasSolidos = [
    {'label': 'Gramos', 'value': 'g'},
    {'label': 'Cucharadas', 'value': 'c'},
    {'label': 'Tazas', 'value': 't'},
    {'label': 'Kilogramos', 'value': 'Kg'}
  ];

  final List _medidasLiquidos = [
    {'label': 'Mililitros', 'value': 'ml'},
    {'label': 'Cucharadas', 'value': 'c'},
    {'label': 'Tazas', 'value': 't'},
    {'label': 'Litros', 'value': 'L'}
  ];

  var _selectedIngrediente;
  double _cantidadIngrediente = 0;
  String _selectedUMedida = '';

  final TextEditingController _cantidadTextController =
      new TextEditingController();

  AgregarPlatPageState() {
    loadPage();
  }

  void loadPage() async {
    final ingredientes = await Database.getAllIngredientes();

    print(ingredientes);

    setState(() {
      _ings = generarListaIngredientes(ingredientes);
    });
  }

  List<DropdownMenuItem<dynamic>> generarListaIngredientes(final lista) {
    List<DropdownMenuItem<dynamic>> _listaIngs = [];

    for (final ing in lista) {
      final DropdownMenuItem<dynamic> _item = DropdownMenuItem<dynamic>(
        child: Text(ing['ingrediente']),
        value: ing,
      );

      _listaIngs.add(_item);
    }

    return _listaIngs;
  }

  List<DropdownMenuItem<dynamic>> generarListaOpcionesMedidas(final lista) {
    List<DropdownMenuItem<dynamic>> _listaMedidas = [];

    for (final medida in lista) {
      final DropdownMenuItem<dynamic> _item = DropdownMenuItem<dynamic>(
        child: Text(medida['label']),
        value: medida['value'],
      );

      _listaMedidas.add(_item);
    }

    return _listaMedidas;
  }

  void addIngrediente() async {
    setState(() {
      _textError = '';
    });

    if (_selectedIngrediente == null) {
      setState(() {
        _textError = 'Seleccione un ingrediente a añadir';
      });
      return;
    }

    if (_cantidadIngrediente == null || _cantidadIngrediente <= 0) {
      setState(() {
        _textError = 'Inserte una cantidad válida';
      });
      return;
    }

    if (_selectedUMedida == null || _selectedUMedida == '') {
      setState(() {
        _textError = 'Seleccione la unidad de medida';
      });
      return;
    }

    final _ing = {
      'IdIng': _selectedIngrediente['id'],
      'cantidad': _cantidadIngrediente,
      'nombreIng': _selectedIngrediente['ingrediente'],
      'uMedida': _selectedUMedida
    };
    _ingredientesPlatillo.add(_ing);

    setState(() {
      _selectedIngrediente = null;
      _cantidadIngrediente = null;
      _selectedUMedida = null;
    });
    _cantidadTextController.clear();
  }

  void addPlatillo() async {
    setState(() {
      _textError = '';
    });

    if (_nombrePlatillo == '' || _nombrePlatillo == null) {
      setState(() {
        _textError = 'Inserte el nombre del platillo';
      });
      return;
    }

    if (_ingredientesPlatillo.length == 0) {
      setState(() {
        _textError = 'Agregue por lo menos un ingrediente';
      });
      return;
    }

    print('OK');
    final _platillo = {
      'nombreP': _nombrePlatillo,
      'ingredientes': _ingredientesPlatillo
    };

    print(_platillo);

    final res = await Database.postPlatillo(_platillo);
    if (res['status'] == 'OK') {
      setState(() {
        _textError = 'OK';
      });
      Navigator.of(context).pop(() {
        setState(() {});
      });
    } else {
      setState(() {
        _textError = res['mensaje'];
      });
    }
  }

  Widget build(context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(children: <Container>[
      Container(
          margin: EdgeInsets.only(
              top: MediaQuery.of(context).size.height * 0.06,
              left: 20,
              bottom: 10),
          child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Agregar Platillo',
                style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'sans-serif-medium',
                    color: Color.fromARGB(255, 0, 0, 0)),
              ))),
      Container(
          margin: EdgeInsets.only(left: 15, right: 15, bottom: 5),
          child: TextField(
              decoration: InputDecoration(hintText: 'Nombre del Platillo'),
              onChanged: (value) {
                _nombrePlatillo = value;
                print(_nombrePlatillo);
              })),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        height: MediaQuery.of(context).size.height * 0.20,
        child: Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: 2.0, color: Color.fromARGB(255, 222, 0, 16)),
                        bottom: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(255, 222, 0, 16)))),
                child: ListView.builder(
                  itemCount: _ingredientesPlatillo.length,
                  itemBuilder: (context, index) {
                    return Container(
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    width: 1.0,
                                    color:
                                        Color.fromARGB(255, 221, 221, 221)))),
                        child: Container(
                            margin:
                                EdgeInsets.only(left: 20, top: 10, bottom: 10),
                            child: Center(
                                child: Row(children: <Container>[
                              Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.60,
                                  child: Text(
                                    _ingredientesPlatillo[index]['nombreIng'],
                                    style: TextStyle(fontSize: 30),
                                  )),
                              Container(
                                  margin: EdgeInsets.zero,
                                  child: Text(
                                    '${_ingredientesPlatillo[index]['cantidad'].toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")} ${_ingredientesPlatillo[index]['uMedida']}',
                                    style: TextStyle(fontSize: 30),
                                  ))
                            ]))));
                  },
                ))),
      ),

      ////////// PICKER ///////////
      Container(
          margin: EdgeInsets.zero,
          child: DropdownButton<dynamic>(
              hint: Text('Ingrediente'),
              value: _selectedIngrediente,
              items: _ings,
              onChanged: (e) {
                setState(() {
                  _selectedIngrediente = e;

                  if (_selectedIngrediente['uMedida'] == 'g' ||
                      _selectedIngrediente['uMedida'] == 'Kg') {
                    _opcionMedida =
                        generarListaOpcionesMedidas(_medidasSolidos);
                  } else {
                    _opcionMedida =
                        generarListaOpcionesMedidas(_medidasLiquidos);
                  }

                  _selectedUMedida = null;
                  _cantidadIngrediente = null;
                });

                _cantidadTextController.clear();
                print(_selectedIngrediente);
              })),
      Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Container>[
            Container(
                margin: EdgeInsets.only(right: 5),
                width: MediaQuery.of(context).size.width * 0.50,
                child: TextField(
                    controller: _cantidadTextController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Cantidad',
                    ),
                    onChanged: (value) {
                      if (double.tryParse(value) != null) {
                        _cantidadIngrediente = double.parse(value);
                      } else {
                        _cantidadIngrediente = 0;
                      }
                      print(_cantidadIngrediente);
                    })),
            Container(
                margin: EdgeInsets.zero,
                child: DropdownButton(
                    hint: Text('Unidad'),
                    value: _selectedUMedida,
                    items: _opcionMedida,
                    onChanged: (e) {
                      setState(() {
                        _selectedUMedida = e;
                      });

                      print(_selectedUMedida);
                    })),
          ],
        ),
      ),

      /////// ERROR TEXT /////////
      Container(
          margin: EdgeInsets.only(top: 20, left: 20, right: 20, bottom: 20),
          height: 50,
          child: Center(
              child: Text(_textError,
                  style: TextStyle(
                      fontSize: 18, color: Color.fromARGB(255, 255, 0, 0))))),
      Container(
          margin: EdgeInsets.only(left: 30, right: 30),
          height: 60,
          child: SizedBox.expand(
              child: ElevatedButton(
                  onPressed: () {
                    addIngrediente();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 222, 0, 16)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  child: Text("Agregar Ingrediente",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontFamily: 'sans-serif-medium'))))),
      Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: 25),
          height: 60,
          child: SizedBox.expand(
              child: ElevatedButton(
                  onPressed: () {
                    addPlatillo();
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Color.fromARGB(255, 222, 0, 16)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)))),
                  child: Text("Agregar Platillo",
                      style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontFamily: 'sans-serif-medium')))))
    ])));
  }
}
