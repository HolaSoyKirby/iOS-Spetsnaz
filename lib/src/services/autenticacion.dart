import 'package:http/http.dart' as http;
import 'dart:convert';

class Autenticacion {
  static signUp(String email, String password) async {
    const String _key = 'AIzaSyBpUFVaUCA8nP-Yt1cBnpJbe5x5nirA6ys';
    const String _url =
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
      return {'status': 'ERROR', 'mensaje': e.toString()};
    }
  }

  static String signUpError(String errorMessage) {
    switch (errorMessage) {
      case 'INVALID_EMAIL':
        return 'Ingrese un correo válido';
      case 'WEAK_PASSWORD':
        return 'Ingrese una contraseña de al menos 6 caracteres';
      case 'EMAIL_EXISTS':
        return 'El correo ingresado ya existe';
      case 'MISSING_PASSWORD':
        return 'Ingrese una contraseña';
      default:
        return 'Error';
    }
  }
}
