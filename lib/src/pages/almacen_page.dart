import 'package:flutter/material.dart';
import '../services/database.dart';

class AlmacenPage extends StatefulWidget {
  @override
  createState() {
    return AlmacenPageState();
  }
}

class AlmacenPageState extends State<AlmacenPage> {
  @override
  Widget build(context) {
    return (Scaffold(
        body: Column(children: <Container>[
          Container(
              margin: EdgeInsets.only(left: 20, right: 20, top: 50, bottom: 15),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Almacén',
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
                    Navigator.of(context).pushNamed('/agregarIngPage');
                  }),
            ))));
  }

  Widget _lista() {
    //FutureBuilder
    return FutureBuilder(
      future: Database.getAllIngredientes(),
      initialData: [],
      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
        print('builder');
        print(snapshot.data);
        return Expanded(
            child: Container(
                margin: EdgeInsets.zero,
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
    return Container(
        margin: EdgeInsets.zero,
        decoration: BoxDecoration(
            border: Border(
                top: BorderSide(
                    width: 1.0, color: Color.fromARGB(255, 222, 0, 16)))),
        child: ElevatedButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Color.fromARGB(255, 255, 255, 255))),
            onPressed: () {
              Navigator.of(context)
                  .pushNamed('/agregarCantPage', arguments: ingrediente)
                  .then((_) {
                setState(() {});
              });
            },
            child: Column(
              children: <Container>[
                Container(
                    child: ListTile(
                  title: Text(
                    ingrediente['ingrediente'],
                    style: TextStyle(fontSize: 30),
                  ),
                )),
                Container(
                    margin: EdgeInsets.zero,
                    child: ListTile(
                        title: Text(
                      '${ingrediente['cantidad'].toString().replaceAll(RegExp(r"([.]*0)(?!.*\d)"), "")} ${ingrediente['uMedida']}',
                      style: TextStyle(fontSize: 30),
                    )))
              ],
            )));
  }
}
