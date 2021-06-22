import 'package:flutter/material.dart';
import './routes/routes.dart';

class MyApp extends StatelessWidget {
  @override
  build(context) {
    return MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        debugShowCheckedModeBanner: false);
  }
}
