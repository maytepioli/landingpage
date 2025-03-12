import 'dart:math';
import 'package:flutter/material.dart';
import 'sections/home_section.dart';
import 'sections/about_section.dart';
import 'sections/team_section.dart';

class LandingPage extends StatelessWidget {
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey teamKey = GlobalKey();

  LandingPage({Key? key}) : super(key: key);

  void scrollToSection(GlobalKey key, BuildContext context) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Image.asset(
          'assets/images/logo.png',
          height: 40,
          fit: BoxFit.contain,
        ),
        actions: [
          AnimatedNavButton(
            label: 'Home',
            onPressed: () => scrollToSection(homeKey, context),
          ),
          AnimatedNavButton(
            label: 'About',
            onPressed: () => scrollToSection(aboutKey, context),
          ),
          AnimatedNavButton(
            label: 'Team',
            onPressed: () => scrollToSection(teamKey, context),
          ),
        ],
      ),
      body: Stack(
        children: [
          AnimatedCirclesBackground(),
          SingleChildScrollView(
            child: Column(
              children: [
                Container(key: homeKey, child: HomeSection()),
                Container(key: aboutKey, child: AboutSection()),
                Container(key: teamKey, child: TeamSection()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class AnimatedNavButton extends StatefulWidget {
  final VoidCallback onPressed;
  final String label;

  const AnimatedNavButton({
    Key? key,
    required this.onPressed,
    required this.label,
  }) : super(key: key);

  @override
  _AnimatedNavButtonState createState() => _AnimatedNavButtonState();
}

class _AnimatedNavButtonState extends State<AnimatedNavButton> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: Duration(milliseconds: 200),
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          border: _isHovered
              ? Border(
                  bottom: BorderSide(color: Color(0xFF9D4EDD), width: 2),
                )
              : null,
        ),
        child: GestureDetector(
          onTap: widget.onPressed,
          child: Text(
            widget.label,
            style: TextStyle(
              color: Color(0xFF9D4EDD),
              fontSize: 16,
              fontWeight: _isHovered ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}

class CircleData {
  final double startX; // Posición horizontal relativa (0 a 1)
  final double startY; // Posición vertical relativa (0 a 1)
  final double radius;
  final double amplitude; // Amplitud de oscilación (en píxeles)
  final double phase; // Fase inicial para la oscilación

  CircleData({
    required this.startX,
    required this.startY,
    required this.radius,
    required this.amplitude,
    required this.phase,
  });
}

class AnimatedCirclesBackground extends StatefulWidget {
  @override
  _AnimatedCirclesBackgroundState createState() =>
      _AnimatedCirclesBackgroundState();
}

class _AnimatedCirclesBackgroundState extends State<AnimatedCirclesBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<CircleData> circles;
  final int numberOfCircles = 10;

  @override
  void initState() {
    super.initState();
    // Duración del ciclo de oscilación completa
    _controller = AnimationController(
      duration: Duration(seconds: 6),
      vsync: this,
    )..repeat();

    final random = Random();
    circles = List.generate(numberOfCircles, (index) {
      return CircleData(
        startX: random.nextDouble(),
        startY: random.nextDouble(),
        radius: 20.0 + random.nextDouble() * 40,
        amplitude:
            10 + random.nextDouble() * 20, // Oscilación entre 10 y 30 píxeles
        phase: random.nextDouble() * 2 * pi,
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return CustomPaint(
          painter: CirclePainter(
            animationValue: _controller.value,
            circles: circles,
          ),
          size: MediaQuery.of(context).size,
        );
      },
    );
  }
}

class CirclePainter extends CustomPainter {
  final double animationValue;
  final List<CircleData> circles;

  CirclePainter({required this.animationValue, required this.circles});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.deepPurple.withOpacity(0.1);
    for (final circle in circles) {
      // Oscilación horizontal y vertical para un efecto "flotante"
      final horizontalOffset =
          cos(animationValue * 2 * pi + circle.phase) * circle.amplitude;
      final verticalOffset =
          sin(animationValue * 2 * pi + circle.phase) * circle.amplitude;
      final offset = Offset(
        circle.startX * size.width + horizontalOffset,
        circle.startY * size.height + verticalOffset,
      );
      canvas.drawCircle(offset, circle.radius, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CirclePainter oldDelegate) => true;
}
