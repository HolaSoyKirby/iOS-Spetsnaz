import 'package:flutter/material.dart';

class IngredientesPlatilloPage extends StatelessWidget {
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
              'Nombre Platillo',
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
                      Navigator.of(context).pop();
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
    //FutureBuilder
    return FutureBuilder(
      future: _getList(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        print('builder');
        print(snapshot.data);
        return Expanded(
            child: Container(
                margin: EdgeInsets.zero,
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
      opciones.add(_cardt1(data[i]));
    }
    return opciones;
  }

  Widget _cardt1(var ingrediente) {
    return Container(
        margin: EdgeInsets.zero,
        child: ListTile(
          title: Text(
            '- ${ingrediente['Cantidad']} ${ingrediente['Nombre']}',
            style: TextStyle(fontSize: 20),
          ),
        ));
  }
}
