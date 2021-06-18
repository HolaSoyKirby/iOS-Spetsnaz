import 'package:http/http.dart' as http;
import 'dart:convert';

class Autenticacion {
  static final String _key = 'AIzaSyBpUFVaUCA8nP-Yt1cBnpJbe5x5nirA6ys';

  static signUp(String email, String password) async {
    final String _url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=${_key}';

    try {
      final response = await http.post(_url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));

      final responseData = await json.decode(response.body);
      if (responseData['error'] != null) {
        return {
          'status': 'ERROR',
          'mensaje': signUpError(responseData['error']['message'])
        };
      } else {
        return {'status': 'OK', 'mensaje': responseData['email']};
      }
    } catch (e) {
      print("OH SNAP");
      return {'status': 'ERROR', 'mensaje': e.toString()};
    }
  }

  static String signUpError(String errorMessage) {
    switch (errorMessage) {
      case 'INVALID_EMAIL':
        return 'Ingrese un correo válido';
      case 'WEAK_PASSWORD : Password should be at least 6 characters':
        return 'Ingrese una contraseña de al menos 6 caracteres';
      case 'EMAIL_EXISTS':
        return 'El correo ingresado ya existe';
      case 'MISSING_PASSWORD':
        return 'Ingrese una contraseña';
      default:
        return errorMessage;
    }
  }

  static singIn(String email, String password) async {
    final String _url =
        'https://identitytoolkit.googleapis.com/v1/accounts:signInWithPassword?key=${_key}';

    try {
      final response = await http.post(_url,
          body: json.encode({
            'email': email,
            'password': password,
            'returnSecureToken': true
          }));

      final responseData = await json.decode(response.body);
      if (responseData['error'] != null) {
        print(responseData['error']);
        return {
          'status': 'ERROR',
          'mensaje': signInError(responseData['error']['message'])
        };
      } else {
        return {'status': 'OK', 'mensaje': responseData['email']};
      }
    } catch (e) {
      print("OH SNAP");
      return {'status': 'ERROR', 'mensaje': e.toString()};
    }
  }

  static String signInError(String errorMessage) {
    switch (errorMessage) {
      case 'INVALID_EMAIL':
        return 'Ingrese un correo válido';
      case 'MISSING_PASSWORD':
        return 'Ingrese la contraseña';
      case 'EMAIL_NOT_FOUND':
        return 'Ingrese un correo actualmente registrado';
      case 'INVALID_PASSWORD':
        return 'Contraseña incorrecta';
      default:
        return errorMessage;
    }
  }
}
