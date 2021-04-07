import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../components/menu_drawer.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => LoginPage());
      case '/registerPage':
        return MaterialPageRoute(builder: (_) => RegisterPage());
      case '/menuPage':
        return MaterialPageRoute(builder: (_) => MenuDrawer());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
