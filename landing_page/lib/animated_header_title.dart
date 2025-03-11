import 'package:flutter/material.dart';

class AnimatedHeaderTitle extends StatefulWidget {
  final String text;

  const AnimatedHeaderTitle({Key? key, required this.text}) : super(key: key);

  @override
  _AnimatedHeaderTitleState createState() => _AnimatedHeaderTitleState();
}

class _AnimatedHeaderTitleState extends State<AnimatedHeaderTitle>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    // Controlador que repite la animación para dar efecto de pulso
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Text(
        widget.text,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
