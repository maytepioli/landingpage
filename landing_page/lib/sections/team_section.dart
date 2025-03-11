import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class TeamSection extends StatefulWidget {
  const TeamSection({Key? key}) : super(key: key);

  @override
  _TeamSectionState createState() => _TeamSectionState();
}

class _TeamSectionState extends State<TeamSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    // Animación global para la sección del equipo
    _controller = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
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
    return Container(
      padding: EdgeInsets.all(16.0),
      // Degradado sutil de fondo
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Color(0xFF9D4EDD).withOpacity(0.02)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Define un umbral para considerar el dispositivo como móvil.
            bool isMobile = constraints.maxWidth < 600;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                // Título "TEAM" centrado, más grande y con mayor grosor
                Text(
                  'Team',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF9D4EDD),
                  ),
                ),
                SizedBox(height: 16),
                // Selecciona el layout según el ancho disponible
                isMobile
                    ? Column(
                        children: [
                          TeamMember(
                            delay: 0,
                            name: 'Mayte Pioli',
                            role: 'Project manager & Frontend developer',
                            imageCircle: 'assets/team/mayte.jpg',
                            linkedinUrl:
                                'https://www.linkedin.com/in/mayte-pioli-454b42342/',
                            email: 'piolimayte@gmail.com',
                          ),
                          SizedBox(height: 20),
                          TeamMember(
                            delay: 200,
                            name: 'Ariel Diaz',
                            role: 'Backend developer',
                            imageCircle: 'assets/team/ariel.jpg',
                            linkedinUrl:
                                'https://www.linkedin.com/in/ariel-d%C3%ADaz-948a5b2a1/',
                            email: 'ariel@example.com',
                          ),
                          SizedBox(height: 20),
                          TeamMember(
                            delay: 400,
                            name: 'Julieta Bobadilla',
                            role: 'Backend developer',
                            imageCircle: 'assets/team/julieta.jpg',
                            linkedinUrl:
                                'https://www.linkedin.com/in/julieta-bobadilla-b58581247/',
                            email: 'julietabobadilla123@gmail.com',
                          ),
                        ],
                      )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TeamMember(
                            delay: 0,
                            name: 'Mayte Pioli',
                            role: 'Project manager & Frontend developer',
                            imageCircle: 'assets/team/mayte.jpg',
                            linkedinUrl:
                                'https://www.linkedin.com/in/mayte-pioli-454b42342/',
                            email: 'piolimayte@gmail.com',
                          ),
                          TeamMember(
                            delay: 200,
                            name: 'Ariel Diaz',
                            role: 'Backend developer',
                            imageCircle: 'assets/team/ariel.jpg',
                            linkedinUrl:
                                'https://www.linkedin.com/in/ariel-d%C3%ADaz-948a5b2a1/',
                            email: 'ariel@example.com',
                          ),
                          TeamMember(
                            delay: 400,
                            name: 'Julieta Bobadilla',
                            role: 'Backend developer',
                            imageCircle: 'assets/team/julieta.jpg',
                            linkedinUrl:
                                'https://www.linkedin.com/in/julieta-bobadilla-b58581247/',
                            email: 'julietabobadilla123@gmail.com',
                          ),
                        ],
                      ),
                SizedBox(height: 50),
              ],
            );
          },
        ),
      ),
    );
  }
}

// Widget que encapsula cada miembro del equipo con animación de aparición
class TeamMember extends StatelessWidget {
  final int delay;
  final String name;
  final String role;
  final String imageCircle;
  final String linkedinUrl;
  final String email;

  const TeamMember({
    Key? key,
    required this.delay,
    required this.name,
    required this.role,
    required this.imageCircle,
    required this.linkedinUrl,
    required this.email,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: Duration(milliseconds: 800),
      builder: (context, opacity, child) {
        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: Column(
        children: [
          AnimatedCircleImage(
            imagePath: imageCircle,
            radius: 100,
          ),
          SizedBox(height: 8),
          // Nombre en Poppins
          Text(
            name,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF9D4EDD),
            ),
          ),
          SizedBox(height: 4),
          // Rol en Poppins
          Text(
            role,
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: Colors.black87,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          // Fila de íconos: LinkedIn y Email
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LinkedInIcon(linkedInUrl: linkedinUrl),
              SizedBox(width: 16),
              EmailIcon(email: email),
            ],
          ),
        ],
      ),
    );
  }
}

// Widget para el ícono de LinkedIn usando Font Awesome y url_launcher
class LinkedInIcon extends StatelessWidget {
  final String linkedInUrl;

  const LinkedInIcon({Key? key, required this.linkedInUrl}) : super(key: key);

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(linkedInUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir $linkedInUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        FontAwesomeIcons.linkedin,
        size: 40,
        color: Color(0xFF9D4EDD),
      ),
      onPressed: _launchURL,
    );
  }
}

// Widget para el ícono de Email usando Font Awesome y url_launcher
class EmailIcon extends StatelessWidget {
  final String email;

  const EmailIcon({Key? key, required this.email}) : super(key: key);

  Future<void> _launchEmail() async {
    final Uri uri = Uri.parse('mailto:$email');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'No se pudo abrir mailto:$email';
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        FontAwesomeIcons.envelope,
        size: 40,
        color: Color(0xFF9D4EDD),
      ),
      onPressed: _launchEmail,
    );
  }
}

// Widget personalizado para mostrar la imagen circular con animación y efecto hover
class AnimatedCircleImage extends StatefulWidget {
  final String imagePath;
  final double radius;

  const AnimatedCircleImage({
    Key? key,
    required this.imagePath,
    this.radius = 40,
  }) : super(key: key);

  @override
  _AnimatedCircleImageState createState() => _AnimatedCircleImageState();
}

class _AnimatedCircleImageState extends State<AnimatedCircleImage> {
  bool _isHovered = false;
  double _baseScale = 0.8;

  @override
  void initState() {
    super.initState();
    // Animación inicial: de 0.8 a 1.0
    Future.delayed(Duration(milliseconds: 50), () {
      if (mounted) {
        setState(() {
          _baseScale = 1.0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Si se pasa el mouse, aumentamos la escala un 5%
    double scaleFactor = _baseScale * (_isHovered ? 1.05 : 1.0);

    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          _isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        transform: Matrix4.identity()..scale(scaleFactor),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: _isHovered
              ? [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ]
              : [],
        ),
        child: ClipOval(
          child: Image.asset(
            widget.imagePath,
            width: widget.radius * 2,
            height: widget.radius * 2,
            fit: BoxFit.cover,
            // Alineación ajustada para mostrar mejor la parte superior
            alignment: Alignment(0, -1),
          ),
        ),
      ),
    );
  }
}
