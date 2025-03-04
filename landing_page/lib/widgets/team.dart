import 'package:flutter/material.dart';

class TeamSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Lista de integrantes del equipo (usa imágenes reales o placeholders)
    final List<Map<String, String>> teamMembers = [
      {'name': 'Mayte', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Ariel', 'image': 'https://via.placeholder.com/150'},
      {'name': 'Julieta', 'image': 'https://via.placeholder.com/150'},
    ];

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 60, horizontal: 20),
      child: Column(
        children: [
          Text(
            'Nuestro Equipo',
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 30),
          Wrap(
            spacing: 20,
            runSpacing: 20,
            alignment: WrapAlignment.center,
            children: teamMembers.map((member) {
              return TeamMemberCard(
                name: member['name']!,
                image: member['image']!,
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}

class TeamMemberCard extends StatefulWidget {
  final String name;
  final String image;

  const TeamMemberCard({Key? key, required this.name, required this.image})
      : super(key: key);

  @override
  _TeamMemberCardState createState() => _TeamMemberCardState();
}

class _TeamMemberCardState extends State<TeamMemberCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedScale(
        scale: _hovering ? 1.2 : 1.0,
        duration: Duration(milliseconds: 200),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(widget.image),
            ),
            SizedBox(height: 10),
            Text(
              widget.name,
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
