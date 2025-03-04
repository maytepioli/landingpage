import 'package:flutter/material.dart';
import 'landing_page.dart';

void main() {
  runApp(MyLandingPage());
}

class MyLandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home:
          LandingPage(), // Se utiliza la pantalla principal definida en landing_page.dart
    );
  }
}
