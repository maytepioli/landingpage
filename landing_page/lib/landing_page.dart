import 'package:flutter/material.dart';
import 'widgets/header.dart';
import 'widgets/home.dart';
import 'widgets/about.dart';
import 'widgets/team.dart';

class LandingPage extends StatelessWidget {
  // Declaramos las GlobalKeys para cada sección
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey teamKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // El Header recibe el callback onMenuTap para manejar el scroll a cada sección
            Header(
              onMenuTap: (String section) {
                switch (section) {
                  case 'Inicio':
                    Scrollable.ensureVisible(
                      homeKey.currentContext!,
                      duration: Duration(milliseconds: 500),
                    );
                    break;
                  case 'About':
                    Scrollable.ensureVisible(
                      aboutKey.currentContext!,
                      duration: Duration(milliseconds: 500),
                    );
                    break;
                  case 'Equipo':
                    Scrollable.ensureVisible(
                      teamKey.currentContext!,
                      duration: Duration(milliseconds: 500),
                    );
                    break;
                }
              },
            ),
            // Cada sección se envuelve en un Container al que se le asigna su GlobalKey
            Container(key: homeKey, child: HomeSection()),
            Container(key: aboutKey, child: AboutSection()),
            Container(key: teamKey, child: TeamSection()),
          ],
        ),
      ),
    );
  }
}
