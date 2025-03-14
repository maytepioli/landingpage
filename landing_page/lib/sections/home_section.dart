import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HOPEBOX Landing Page',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(child: HomeSection()),
      ),
    );
  }
}

class HomeSection extends StatefulWidget {
  const HomeSection({Key? key}) : super(key: key);

  @override
  _HomeSectionState createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Controlador para la animación de fade-in
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Obtenemos el ancho de la pantalla para determinar si es móvil
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    // Contenido de texto animado
    final textContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 50),
        // Título principal animado
        TweenAnimationBuilder<Offset>(
          tween: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero),
          duration: const Duration(milliseconds: 800),
          builder: (context, offset, child) {
            return Transform.translate(
              offset: offset * 100,
              child: Container(
                width: double.infinity,
                child: child,
              ),
            );
          },
          child: Text(
            'introducing HOPE BOX!',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF9D4EDD),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 16),
        // Subtítulo animado
        TweenAnimationBuilder<Offset>(
          tween: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero),
          duration: const Duration(milliseconds: 800),
          builder: (context, offset, child) {
            return Transform.translate(
              offset: offset * 100,
              child: Container(
                width: double.infinity,
                child: child,
              ),
            );
          },
          child: Text(
            'We transform the way we donate',
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 50),
      ],
    );

    // Widget de la imagen
    final imageWidget = Image.asset(
      'assets/team/TELEFONO.png',
      height: 300, // Ajusta la altura según necesites
      fit: BoxFit.contain,
    );

    // Contenido general de Home
    final content = Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: isMobile
            // En móviles se organiza en columna (texto arriba, imagen abajo)
            ? Column(
                children: [
                  textContent,
                  imageWidget,
                ],
              )
            // En pantallas grandes se organiza en fila
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 1,
                    child: textContent,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 1,
                    child: imageWidget,
                  ),
                ],
              ),
      ),
    );

    // Se muestra el contenido sin fondo animado
    return content;
  }
}
