import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AgregarPlatPage extends StatefulWidget {
  @override
  createState() {
    return AgregarPlatPageState();
  }
}

class AgregarPlatPageState extends State<AgregarPlatPage> {
  Future<List> _getList() {
    return Future.value([
      {
        'Nombre': 'Ingrediente 1',
        'Cantidad': '20 kg',
      },
      {
        'Nombre': 'Ingrediente 2',
        'Cantidad': '20 kg',
      },
      {
        'Nombre': 'Ingrediente 3',
        'Cantidad': '200 g',
      },
      {
        'Nombre': 'Ingrediente 4',
        'Cantidad': '20 kg',
      },
      {
        'Nombre': 'Ingrediente 5',
        'Cantidad': '20 kg',
      },
      {
        'Nombre': 'Ingrediente 6',
        'Cantidad': '200 g',
      },
      {
        'Nombre': 'Ingrediente 7',
        'Cantidad': '20 kg',
      },
      {
        'Nombre': 'Ingrediente 8',
        'Cantidad': '20 kg',
      },
      {
        'Nombre': 'Ingrediente 9',
        'Cantidad': '200 g',
      },
      {
        'Nombre': 'Ingrediente 10',
        'Cantidad': '20 kg',
      },
      {
        'Nombre': 'Ingrediente 11',
        'Cantidad': '20 kg',
      },
      {
        'Nombre': 'Ingrediente 12',
        'Cantidad': '200 g',
      }
    ]);
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
              decoration: InputDecoration(hintText: 'Nombre del Platillo'))),
      Container(
        margin: EdgeInsets.symmetric(vertical: 15),
        height: MediaQuery.of(context).size.height * 0.20,
        child: _lista(),
      ),

      ////////// PICKER ///////////
      Container(
        child: Text(
          'Ingredientes:',
          style: TextStyle(color: Color.fromARGB(255, 255, 0, 0)),
        ),
      ),
      Container(
          margin: EdgeInsets.zero,
          child: DropdownButton(
              hint: Text('Ingrediente'),
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
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Container>[
            Container(
                margin: EdgeInsets.only(right: 5),
                width: MediaQuery.of(context).size.width * 0.50,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Cantidad',
                  ),
                )),
            Container(
                margin: EdgeInsets.zero,
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
          ],
        ),
      ),
      Container(
          margin: EdgeInsets.only(left: 30, right: 30, top: 25),
          height: 60,
          child: SizedBox.expand(
              child: ElevatedButton(
                  onPressed: () {},
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
                    Navigator.of(context).pop();
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

  Widget _lista() {
    //FutureBuilder
    return FutureBuilder(
      future: _getList(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        print('builder');
        print(snapshot.data);
        return Expanded(
            child: Container(
                margin: EdgeInsets.only(left: 5, right: 5),
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
                            width: 2.0, color: Color.fromARGB(255, 222, 0, 16)),
                        bottom: BorderSide(
                            width: 2.0,
                            color: Color.fromARGB(255, 222, 0, 16)))),
                child: ListView(
                  children: _listaImgs(snapshot.data, context),
                )));
      },
    );
  }

  List<Widget> _listaImgs(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    for (int i = 0; i < data.length; i++) {
      print(data[i]);
      opciones.add(_cardt1(data[i], context));
    }
    return opciones;
  }

  Widget _cardt1(var ingrediente, BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: 1.0, color: Color.fromARGB(255, 221, 221, 221)))),
        child: Container(
            margin: EdgeInsets.only(left: 20, top: 10, bottom: 10),
            child: Center(
                child: Row(children: <Container>[
              Container(
                  width: MediaQuery.of(context).size.width * 0.60,
                  child: Text(
                    ingrediente['Nombre'],
                    style: TextStyle(fontSize: 30),
                  )),
              Container(
                  margin: EdgeInsets.zero,
                  child: Text(
                    ingrediente['Cantidad'],
                    style: TextStyle(fontSize: 30),
                  ))
            ]))));
  }
}
