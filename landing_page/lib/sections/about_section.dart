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
        body: SingleChildScrollView(child: AboutSection()),
      ),
    );
  }
}

class AboutSection extends StatefulWidget {
  const AboutSection({Key? key}) : super(key: key);

  @override
  _AboutSectionState createState() => _AboutSectionState();
}

class _AboutSectionState extends State<AboutSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.2), end: Offset.zero)
            .animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Texto introductorio (contenido interno)
  Widget _buildIntroText(BuildContext context, bool isMobile) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome to HOPEBOX, where our goal is to simplify the way you donate. We believe that contributing to a cause should be a quick, intuitive, and effective process. That's why we've designed an app that connects you directly with donation centers, allowing you to upload your donation, describe it, and choose one or more centers that may need it.",
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(fontSize: 18, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          Text(
            "In HOPEBOX, you'll find clear categories—such as food, clothing, toys, and pet supplies—that help you direct your donation precisely. Once you enter your donation information, an interactive map will allow you to select the centers to which you should send your donation. This way, if a center rejects your donation due to a surplus or because another center needs it more, you always have the option of submitting other requests.",
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(fontSize: 18, color: Colors.black87),
          ),
          const SizedBox(height: 16),
          Text(
            "Below, we invite you to explore a visual tour of our interface, which will show you step-by-step how to navigate the app and take advantage of all its features.",
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontSize: 18,
              color: Colors.black87,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    // Ajustamos el breakpoint para tablet a 900px
    final isMobile = screenWidth < 900;

    // Contenido de la sección About (título, texto y elementos zigzag)
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 50),
        // Título "About Us"
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'About Us',
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(
              fontSize: 42,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF9D4EDD),
            ),
          ),
        ),
        const SizedBox(height: 16),
        SlideTransition(
          position: _slideAnimation,
          child: _buildIntroText(context, isMobile),
        ),
        const SizedBox(height: 50),
        // Sección Zigzag con imagen y texto.
        const ZigzagItem(
          imageAsset: 'assets/team/celular2.png',
          description:
              'Choose your donation category: Start the process by selecting the type of item you want to donate. The interface presents you with intuitive options such as food, clothing, toys, and pet supplies, so your donation is directed to the right area.',
          imageLeft: false,
        ),
        const SizedBox(height: 30),
        const ZigzagItem(
          imageAsset: 'assets/team/celular3.png',
          description:
              "Describe your donation: Once you've chosen a category, enter a title and description that best represent your item. This information is key for donation centers to understand your offer and assess their needs.",
          imageLeft: true,
        ),
        const SizedBox(height: 30),
        const ZigzagItem(
          imageAsset: 'assets/team/celular.png',
          description:
              "Select one or more donation centers: View available centers on a map and choose the one or more centers you wish to send your donation to. If a center rejects your donation due to a surplus or because another center needs it more, you always have the option of submitting other requests.",
          imageLeft: false,
        ),
        const SizedBox(height: 50),
      ],
    );

    // Envuelve el contenido en un DoubleWaveCard para aplicar el efecto de ola en la parte superior e inferior.
    return DoubleWaveCard(
      width: screenWidth,
      gradient: LinearGradient(
        colors: [Colors.white, const Color(0xFF9D4EDD).withOpacity(0.05)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: content,
      ),
    );
  }
}

// Widget para cada elemento en zigzag (imagen y descripción) con animación de fundido y desplazamiento.
class ZigzagItem extends StatefulWidget {
  final String imageAsset;
  final String description;
  final bool imageLeft;

  const ZigzagItem({
    Key? key,
    required this.imageAsset,
    required this.description,
    required this.imageLeft,
  }) : super(key: key);

  @override
  _ZigzagItemState createState() => _ZigzagItemState();
}

class _ZigzagItemState extends State<ZigzagItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // Se mantiene el breakpoint para mobile en 900px.
      bool isMobile = constraints.maxWidth < 900;

      // Widget de la imagen.
      Widget imageWidget = Container(
        width: isMobile ? double.infinity : 450,
        height: isMobile ? 400 : 450,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(widget.imageAsset),
            fit: BoxFit.cover,
          ),
        ),
      );

      // Widget del texto dentro de una Card.
      Widget textWidget = Card(
        color: const Color(0xFFEEE4F3),
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        child: Container(
          padding: const EdgeInsets.all(16.0),
          constraints: isMobile
              ? const BoxConstraints(maxWidth: 350)
              : const BoxConstraints(maxWidth: 450),
          child: Text(
            widget.description,
            textAlign: TextAlign.left,
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.black87),
          ),
        ),
      );

      // Conservamos la estructura zigzag original.
      Widget content = isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imageWidget,
                const SizedBox(height: 24),
                textWidget,
              ],
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imageLeft
                  ? [imageWidget, const SizedBox(width: 16), textWidget]
                  : [textWidget, const SizedBox(width: 16), imageWidget],
            );

      return FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child: content,
        ),
      );
    });
  }
}

// DoubleWaveCard: contenedor con efecto de ola en la parte superior y en la inferior.
class DoubleWaveCard extends StatelessWidget {
  final Widget child;
  final double width;
  final Color? color;
  final Gradient? gradient;

  const DoubleWaveCard({
    Key? key,
    required this.child,
    required this.width,
    this.color,
    this.gradient,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: DoubleWaveClipper(),
      child: Container(
        width: width,
        decoration: gradient != null
            ? BoxDecoration(gradient: gradient)
            : BoxDecoration(color: color),
        padding: const EdgeInsets.all(24.0),
        child: child,
      ),
    );
  }
}

// DoubleWaveClipper: crea una forma de ola tanto en la parte superior como en la inferior.
class DoubleWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final topWaveHeight = 40.0;
    final bottomWaveHeight = 40.0;
    final path = Path();
    // Comienza en la parte izquierda, justo debajo de la ola superior.
    path.moveTo(0, topWaveHeight);
    // Ola superior: curva desde la izquierda hasta la derecha.
    path.quadraticBezierTo(
      size.width / 2,
      0,
      size.width,
      topWaveHeight,
    );
    // Línea hasta la parte inferior, antes de la ola inferior.
    path.lineTo(size.width, size.height - bottomWaveHeight);
    // Ola inferior: curva desde la derecha hasta la izquierda.
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      0,
      size.height - bottomWaveHeight,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
