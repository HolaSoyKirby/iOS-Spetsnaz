import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Database {
  static final String _key = 'AIzaSyBpUFVaUCA8nP-Yt1cBnpJbe5x5nirA6ys',
      _baseUrl = 'https://firestore.googleapis.com/v1/';

  static Future<List> getAllIngredientes() async {
    final String _url =
        "${_baseUrl}projects/flutter-spetsnaz/databases/(default)/documents/almacen?key=$_key";
    final response = await http.get(_url);
    final responseData = await json.decode(response.body);

    List ingredientes = [];

    for (final ing in responseData['documents']) {
      double _cant = double.parse(ing['fields']['cantidad']['integerValue']);
      String _uMed = ing['fields']['uMedida']['stringValue'];

      if (_cant >= 1000) {
        _cant /= 1000;
        if (_uMed == 'g') {
          _uMed = 'Kg';
        } else {
          _uMed = 'L';
        }
      }

      final ingrediente = {
        'id': ing['name'],
        'ingrediente': ing['fields']['ingrediente']['stringValue'],
        'cantidad': _cant,
        'uMedida': _uMed
      };

      ingredientes.add(ingrediente);
    }

    ingredientes.sort((a, b) => a['ingrediente'].compareTo(b['ingrediente']));

    return Future.value(ingredientes);
  }

  static getIngrediente(String id) async {
    final String _url = '$_baseUrl$id';
    final response = await http.get(_url);
    final responseData = await json.decode(response.body);

    final ingrediente = {
      'id': responseData['name'],
      'ingrediente': responseData['fields']['ingrediente']['stringValue'],
      'cantidad': int.parse(responseData['fields']['cantidad']['integerValue']),
      'uMedida': responseData['fields']['uMedida']['stringValue']
    };

    return ingrediente;
  }

  static updateIngrediente(String id, double cantidad) async {
    final _ing = await getIngrediente(id);

    final int _cantFinal = (_ing['cantidad'] + cantidad).round();

    print("SIUUU");
    print(_cantFinal);

    final String _url = '$_baseUrl$id?updateMask.fieldPaths=cantidad';
    try {
      final response = await http.patch(_url,
          body: json.encode({
            'fields': {
              'cantidad': {'integerValue': _cantFinal}
            }
          }));

      final responseData = await json.decode(response.body);
      return {'status': 'OK', 'mensaje': responseData.toString()};
    } catch (e) {
      print("OH SNAP");
      return {'status': 'ERROR', 'mensaje': e.toString()};
    }
  }
}
