import 'package:flutter/material.dart';
import 'home_page.dart';  // importando a HomePage separada

void main() {
  runApp(MyApp());
}

Color hexToColor(String hex) {
  hex = hex.replaceAll('#', '');
  if (hex.length == 6) hex = 'FF$hex'; // garante canal alfa
  return Color(int.parse(hex, radix: 16));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pesquisa de Satisfação',
      theme: ThemeData(
        primaryColor: hexToColor('275316'),
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(hexToColor: hexToColor),
    );
  }
}
