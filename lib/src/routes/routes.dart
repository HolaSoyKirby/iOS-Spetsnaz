import 'package:ProyectoSpetsnaz/src/pages/agregar_plat_page.dart';
import 'package:ProyectoSpetsnaz/src/pages/ingredientes_platillo_page.dart';
import 'package:flutter/material.dart';
import '../pages/login_page.dart';
import '../pages/register_page.dart';
import '../components/menu_drawer.dart';
import '../pages/agregar_ing_page.dart';
import '../pages/almacen_page.dart';
import '../pages/agregar_plat_page.dart';
import '../pages/ingredientes_platillo_page.dart';

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
      case '/agregarIngPage':
        return MaterialPageRoute(builder: (_) => AgregarIngPage());
      case '/almacenPage':
        return MaterialPageRoute(builder: (_) => AlmacenPage());
      case '/agregarPlatPage':
        return MaterialPageRoute(builder: (_) => AgregarPlatPage());
      case '/ingredientesPlatilloPage':
        return MaterialPageRoute(builder: (_) => IngredientesPlatilloPage());
      default:
        return MaterialPageRoute(builder: (_) => LoginPage());
    }
  }
}
