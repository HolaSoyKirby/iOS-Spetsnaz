import 'package:flutter/material.dart';

class PlatillosPage extends StatelessWidget {
  Future<List> _getList() {
    return Future.value([
      {'Nombre': 'Platillo 1'},
      {'Nombre': 'Platillo 2'},
      {'Nombre': 'Platillo 3'},
      {'Nombre': 'Platillo 4'},
      {'Nombre': 'Platillo 5'},
      {'Nombre': 'Platillo 6'},
      {'Nombre': 'Platillo 7'},
      {'Nombre': 'Platillo 8'},
      {'Nombre': 'Platillo 9'},
      {'Nombre': 'Platillo 10'},
      {'Nombre': 'Platillo 11'},
      {'Nombre': 'Platillo 12'},
      {'Nombre': 'Platillo 13'},
      {'Nombre': 'Platillo 14'},
      {'Nombre': 'Platillo 15'},
      {'Nombre': 'Platillo 16'},
      {'Nombre': 'Platillo 17'},
      {'Nombre': 'Platillo 18'},
      {'Nombre': 'Platillo 19'},
      {'Nombre': 'Platillo 20'}
    ]);
  }

  @override
  Widget build(context) {
    return (Scaffold(
        body: Column(children: <Container>[
          Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Platillos',
                    style: TextStyle(
                        fontSize: 30,
                        fontFamily: 'sans-serif-medium',
                        color: Colors.black)),
              )),
          Container(
            child: _lista(),
          ),
        ]),
        floatingActionButton: Container(
            height: 70.0,
            width: 70.0,
            child: FittedBox(
              child: FloatingActionButton(
                  backgroundColor: Color.fromARGB(255, 222, 0, 16),
                  child: Icon(Icons.add, size: 30),
                  onPressed: () {
                    Navigator.of(context).pushNamed('/agregarPlatPage');
                  }),
            ))));
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
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(
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
    return Column(
      children: <Container>[
        Container(
            margin: EdgeInsets.zero,
            decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        width: 1.0, color: Color.fromARGB(255, 222, 0, 16)))),
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Color.fromARGB(255, 255, 255, 255))),
                onPressed: () {
                  Navigator.of(context).pushNamed('/ingredientesPlatilloPage');
                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: ListTile(
                      title: Text(
                        ingrediente['Nombre'],
                        style: TextStyle(fontSize: 30),
                      ),
                    ))))
      ],
    );
  }
}
