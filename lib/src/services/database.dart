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

    if (responseData.length > 0) {
      List ingredientes = [];

      for (final ing in responseData['documents']) {
        var _cant = ing['fields']['cantidad']['doubleValue'];
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
  }

  static getIngrediente(String id) async {
    final String _url = '$_baseUrl$id';
    final response = await http.get(_url);
    final responseData = await json.decode(response.body);

    final ingrediente = {
      'id': responseData['name'],
      'ingrediente': responseData['fields']['ingrediente']['stringValue'],
      'cantidad': responseData['fields']['cantidad']['doubleValue'],
      'uMedida': responseData['fields']['uMedida']['stringValue']
    };

    return ingrediente;
  }

  static updateIngrediente(String id, int cantidad) async {
    final String _url = '$_baseUrl$id?updateMask.fieldPaths=cantidad';
    try {
      final response = await http.patch(_url,
          body: json.encode({
            'fields': {
              'cantidad': {'doubleValue': cantidad}
            }
          }));

      final responseData = await json.decode(response.body);
      return {'status': 'OK', 'mensaje': responseData.toString()};
    } catch (e) {
      print("OH SNAP");
      return {'status': 'ERROR', 'mensaje': e.toString()};
    }
  }

  static postIngrediente(String nombreIng, double cant, String uMedida) async {
    final String _url =
        "${_baseUrl}projects/flutter-spetsnaz/databases/(default)/documents/almacen?key=$_key";
    try {
      final response = await http.post(_url,
          body: json.encode({
            'fields': {
              'cantidad': {'doubleValue': cant},
              'ingrediente': {'stringValue': nombreIng},
              'uMedida': {'stringValue': uMedida}
            }
          }));

      final responseData = await json.decode(response.body);
      print(responseData);
      return {'status': 'OK', 'mensaje': responseData.toString()};
    } catch (e) {
      print("OH SNAP");
      return {'status': 'ERROR', 'mensaje': e.toString()};
    }
  }

  static Future<List> getAllPlatillos() async {
    final String _url =
        "${_baseUrl}projects/flutter-spetsnaz/databases/(default)/documents/platillos?key=$_key";

    final response = await http.get(_url);
    final responseData = await json.decode(response.body);

    if (responseData.length > 0) {
      List platillos = [];
      for (final plat in responseData['documents']) {
        List ingredientesPlatillo = [];

        for (final ing in plat['fields']['ingredientes']['arrayValue']
            ['values']) {
          final ingrediente = {
            'IdIng': ing['mapValue']['fields']['IdIng']['stringValue'],
            'nombreIng': ing['mapValue']['fields']['nombreIng']['stringValue'],
            'cantidad': ing['mapValue']['fields']['cantidad']['doubleValue'],
            'uMedida': ing['mapValue']['fields']['uMedida']['stringValue']
          };

          ingredientesPlatillo.add(ingrediente);
        }

        final platillo = {
          'id': plat['name'],
          'nombreP': plat['fields']['nombreP']['stringValue'],
          'ingredientes': ingredientesPlatillo
        };

        platillos.add(platillo);
      }

      platillos.sort((a, b) => a['nombreP'].compareTo(b['nombreP']));

      print('AAAAA');
      print(platillos);
      return Future.value(platillos);
    }
  }

  static postPlatillo(var platillo) async {
    final String _url =
        "${_baseUrl}projects/flutter-spetsnaz/databases/(default)/documents/platillos?key=$_key";

    final _ingredientesFinal = [];

    for (final ing in platillo['ingredientes']) {
      final _ingFinal = {
        'mapValue': {
          'fields': {
            'cantidad': {'doubleValue': ing['cantidad']},
            'nombreIng': {'stringValue': ing['nombreIng']},
            'IdIng': {'stringValue': ing['IdIng']},
            'uMedida': {'stringValue': ing['uMedida']}
          }
        }
      };

      _ingredientesFinal.add(_ingFinal);
    }

    try {
      final response = await http.post(_url,
          body: json.encode({
            'fields': {
              'ingredientes': {
                'arrayValue': {'values': _ingredientesFinal}
              },
              'nombreP': {'stringValue': platillo['nombreP']}
            }
          }));

      final responseData = await json.decode(response.body);
      print(responseData);
      return {'status': 'OK', 'mensaje': responseData.toString()};
    } catch (e) {
      print("OH SNAP");
      return {'status': 'ERROR', 'mensaje': e.toString()};
    }
  }

  static prepararPlatillo(final platillo) async {
    print('INGREDIENTES FINALES');
    try {
      for (final ing in platillo) {
        await updateIngrediente(ing['id'], ing['cantidad']);
      }
    } catch (e) {
      return e;
    }
  }
}
