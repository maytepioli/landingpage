import 'dart:math';
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
      color: Colors.transparent,
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: LayoutBuilder(
          builder: (context, constraints) {
            bool isMobile = constraints.maxWidth < 600;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
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
                isMobile
                    ? Column(
                        children: [
                          TeamMember(
                            delay: 0,
                            name: 'Mayte Pioli',
                            role: 'Project manager & Frontend developer',
                            imageCircle: 'assets/assets/team/mayte.jpg',
                            linkedinUrl:
                                'https://www.linkedin.com/in/mayte-pioli-454b42342/',
                            githubUrl: 'https://github.com/maytepioli',
                          ),
                          SizedBox(height: 20),
                          TeamMember(
                            delay: 200,
                            name: 'Ariel Diaz',
                            role: 'Backend developer',
                            imageCircle: 'assets/assets/team/ariel.jpg',
                            linkedinUrl:
                                'https://www.linkedin.com/in/ariel-d%C3%ADaz-948a5b2a1/',
                            githubUrl: 'https://github.com/ariel2mz',
                          ),
                          SizedBox(height: 20),
                          TeamMember(
                            delay: 400,
                            name: 'Julieta Bobadilla',
                            role: 'Backend developer',
                            imageCircle: 'assets/team/julieta.jpg',
                            linkedinUrl:
                                'https://www.linkedin.com/in/julieta-bobadilla-b58581247/',
                            githubUrl: 'https://github.com/julietab28',
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
                            githubUrl: 'https://github.com/maytepioli',
                          ),
                          TeamMember(
                            delay: 200,
                            name: 'Ariel Diaz',
                            role: 'Backend developer',
                            imageCircle: 'assets/team/ariel.jpg',
                            linkedinUrl:
                                'https://www.linkedin.com/in/ariel-d%C3%ADaz-948a5b2a1/',
                            githubUrl: 'https://github.com/ariel2mz',
                          ),
                          TeamMember(
                            delay: 400,
                            name: 'Julieta Bobadilla',
                            role: 'Backend developer',
                            imageCircle: 'assets/team/julieta.jpg',
                            linkedinUrl:
                                'https://www.linkedin.com/in/julieta-bobadilla-b58581247/',
                            githubUrl: 'https://github.com/julietab28',
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

class TeamMember extends StatefulWidget {
  final int delay;
  final String name;
  final String role;
  final String imageCircle;
  final String linkedinUrl;
  final String githubUrl;

  const TeamMember({
    Key? key,
    required this.delay,
    required this.name,
    required this.role,
    required this.imageCircle,
    required this.linkedinUrl,
    required this.githubUrl,
  }) : super(key: key);

  @override
  _TeamMemberState createState() => _TeamMemberState();
}

class _TeamMemberState extends State<TeamMember> {
  double _opacity = 0;
  Offset _offset = Offset(0, 50);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: widget.delay), () {
      if (mounted) {
        setState(() {
          _opacity = 1;
          _offset = Offset.zero;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 800),
      opacity: _opacity,
      child: Transform.translate(
        offset: _offset,
        child: Column(
          children: [
            AnimatedCircleImage(
              imagePath: widget.imageCircle,
              radius: 100,
            ),
            SizedBox(height: 8),
            Text(
              widget.name,
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF9D4EDD),
              ),
            ),
            SizedBox(height: 4),
            Text(
              widget.role,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                LinkedInIcon(linkedInUrl: widget.linkedinUrl),
                SizedBox(width: 16),
                GithubIcon(githubUrl: widget.githubUrl),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class LinkedInIcon extends StatelessWidget {
  final String linkedInUrl;

  const LinkedInIcon({Key? key, required this.linkedInUrl}) : super(key: key);

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(linkedInUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
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

class GithubIcon extends StatelessWidget {
  final String githubUrl;

  const GithubIcon({Key? key, required this.githubUrl}) : super(key: key);

  Future<void> _launchURL() async {
    final Uri uri = Uri.parse(githubUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir $githubUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        FontAwesomeIcons.github,
        size: 40,
        color: Color(0xFF9D4EDD),
      ),
      onPressed: _launchURL,
    );
  }
}

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
            alignment: Alignment(0, -1),
          ),
        ),
      ),
    );
  }
}
