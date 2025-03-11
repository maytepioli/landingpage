import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
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
    // Determinamos si se trata de una pantalla pequeña (celular)
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 600;

    // Widget con el contenido de texto
    final textContent = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 50),
        // Título principal animado
        TweenAnimationBuilder<Offset>(
          tween: Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero),
          duration: Duration(milliseconds: 800),
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
            'We introducing Hope Box!',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.w600,
              color: Color(0xFF9D4EDD),
            ),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(height: 16),
        // Subtítulo animado
        TweenAnimationBuilder<Offset>(
          tween: Tween<Offset>(begin: Offset(0, 0.3), end: Offset.zero),
          duration: Duration(milliseconds: 800),
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
        SizedBox(height: 50),
      ],
    );

    // Widget de la imagen
    final imageWidget = Image.asset(
      'assets/team/TELEFONO2.png',
      height: 300, // Ajusta la altura según necesites
      fit: BoxFit.contain,
    );

    return Container(
      width: double.infinity, // Ocupar todo el ancho
      decoration: BoxDecoration(
        // Degradado sutil usando el color principal en transparencia
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xFF9D4EDD).withOpacity(0.05)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: isMobile
              // Para móviles se organiza en columna (texto arriba, imagen abajo)
              ? Column(
                  children: [
                    textContent,
                    imageWidget,
                  ],
                )
              // Para pantallas grandes se organiza en fila
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: textContent,
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: imageWidget,
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
