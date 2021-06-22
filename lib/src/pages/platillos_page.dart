import 'package:ProyectoSpetsnaz/src/services/database.dart';
import 'package:flutter/material.dart';

class PlatillosPage extends StatefulWidget {
  @override
  createState() {
    return PlatillosPageState();
  }
}

class PlatillosPageState extends State<PlatillosPage> {
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
                    Navigator.of(context)
                        .pushNamed('/agregarPlatPage')
                        .then((_) {
                      setState(() {});
                    });
                  }),
            ))));
  }

  Widget _lista() {
    //FutureBuilder
    return FutureBuilder(
      future: Database.getAllPlatillos(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.data != null) {
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
        } else {
          return Expanded(
              child: Center(child: Text('No hay platillos todavía')));
        }
      },
    );
  }

  List<Widget> _listaImgs(List<dynamic> data, BuildContext context) {
    final List<Widget> opciones = [];

    for (int i = 0; i < data.length; i++) {
      opciones.add(_cardt1(data[i], context));
    }
    return opciones;
  }

  Widget _cardt1(var platillo, BuildContext context) {
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
                  Navigator.of(context)
                      .pushNamed('/ingredientesPlatilloPage',
                          arguments: platillo)
                      .then((_) {
                    setState(() {});
                  });
                },
                child: Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: ListTile(
                      title: Text(
                        platillo['nombreP'],
                        style: TextStyle(fontSize: 30),
                      ),
                    ))))
      ],
    );
  }
}
