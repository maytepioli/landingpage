import 'package:flutter/material.dart';

class HomeSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      // Se ha eliminado el color de fondo para que no aparezca el cuadrado celeste.
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Bienvenido a Mi App',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 15),
          Text(
            'hola.',
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          // Se ha eliminado el ElevatedButton.
        ],
      ),
    );
  }
}
