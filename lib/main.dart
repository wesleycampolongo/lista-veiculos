import 'package:flutter/material.dart';
import 'package:lista_veiculos/screens/list_trucks.dart';
import 'package:lista_veiculos/screens/out_map.dart';

void main() {
  runApp(MainScreen());
}

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          primaryColor: Colors.deepOrange
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => ListTrucks(),
        '/mapa': (context) => Mapa(),
      },
    );
  }
}
