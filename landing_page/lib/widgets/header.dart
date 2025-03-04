import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  // Callback que se ejecuta al tocar un ítem del menú.
  final Function(String) onMenuTap;

  // Constructor que requiere el callback.
  Header({required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent, // Barra transparente.
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center, // Centra los botones.
        children: [
          _menuItem('Home'),
          SizedBox(width: 15),
          _menuItem('About'),
          SizedBox(width: 15),
          _menuItem('Team'),
        ],
      ),
    );
  }

  Widget _menuItem(String title) {
    return TextButton(
      onPressed: () {
        // Al tocar un elemento, se invoca el callback pasando el título.
        onMenuTap(title);
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.black87,
        backgroundColor:
            Colors.white.withOpacity(0.7), // Fondo semitransparente.
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Bordes redondeados.
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      ),
      child: Text(
        title,
        style: TextStyle(fontSize: 16),
      ),
    );
  }
}
