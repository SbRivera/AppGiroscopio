import 'package:flutter/material.dart';
import 'vista/pantalla_principal.dart';

void main() {
  runApp(ControlGiroscopioApp());
}

class ControlGiroscopioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Control del Giroscopio',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PantallaPrincipal(),
    );
  }
}
