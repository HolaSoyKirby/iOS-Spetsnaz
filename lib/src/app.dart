import 'package:ProyectoSpetsnaz/src/pages/profile_page.dart';
import 'package:flutter/material.dart';
import './routes/routes.dart';

import './pages/login_page.dart';
import './pages/register_page.dart';
import './pages/profile_page.dart';
import './pages/platillos_page.dart';

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false);
  }
}
