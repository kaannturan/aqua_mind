// ignore_for_file: library_private_types_in_public_api

import 'dart:math';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size(width, height * 0.1),
        child: ClipPath(
          clipper: AppBarClipper(),
          child: AppBar(
            backgroundColor: Color(0xFF062549),
            elevation: 0,
            title: Text(
              "AquaMind",
              style: TextStyle(
                color: Colors.white,
                fontSize: width * 0.06,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      drawer: SizedBox(
        width: 250,
        child: Drawer(
          backgroundColor: Color(0xFF062549),
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              SizedBox(
                height: height * 0.17,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color(0xFF062549),
                  ),
                  child: Text(
                    'AquaMind',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 23,
                    ),
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Ana Sayfa'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Ayarlar'),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Hakkımızda'),
              ),
              ListTile(
                leading: Icon(Icons.mail),
                title: Text('Görüşlerinizi Bildirin'),
              ),
              SizedBox(height: height * 0.54),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    "2026@AquaMind",
                    style: TextStyle(color: Colors.white70, fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Icon(
                      FontAwesomeIcons.droplet,
                      color: Colors.blue.shade300,
                      size: width * 0.05,
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      "İyi Günler",
                      style: TextStyle(
                        fontSize: width * 0.05,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Stack(
                    children: [
                      ClipPath(
                        clipper: WaterDropClipper(),
                        child: SizedBox(
                          width: width,
                          height: height * 0.5,
                          child: WaterWaveFill(),
                        ),
                      ),
                      CustomPaint(
                        size: Size(width, height * 0.5),
                        painter: WaterStack(),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: height * 0.03),
              Text("  500 / 2400 ml   "),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Günlük Hedefiniz : 2.4 Litre",
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // Tıklama olayı
                      },
                      borderRadius: BorderRadius.circular(60),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Colors.blue.shade300,
                              Colors.blue.shade600,
                            ],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.5),
                              blurRadius: 20,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.glassWater,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "200 ml",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () {
                        // Tıklama olayı
                      },
                      borderRadius: BorderRadius.circular(60),
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              Colors.blue.shade300,
                              Colors.yellow,
                            ],
                          ),
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.5),
                              blurRadius: 20,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              FontAwesomeIcons.glassWater,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(height: 8),
                            Text(
                              "200 ml",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.bottleDroplet,
                        color: Colors.blue.shade300,
                      ),
                      SizedBox(height: height * 0.005),
                      Text(
                        "00 ml",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.downLong,
                        color: Colors.blue.shade300,
                      ),
                      SizedBox(height: height * 0.005),
                      Text(
                        "100 ml",
                        style: TextStyle(color: Colors.white70, fontSize: 13),
                      )
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

// su damlası şekli
class WaterDropClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    path.moveTo(size.width * 0.5, size.height * 0.05);

    path.cubicTo(
      size.width * 0.65,
      size.height * 0.60,
      size.width * 1.05,
      size.height * 0.78,
      size.width * 0.50,
      size.height * 1.00,
    );

    path.cubicTo(
      size.width * -0.05,
      size.height * 0.78,
      size.width * 0.35,
      size.height * 0.60,
      size.width * 0.50,
      size.height * 0.05,
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}

// su kenarı
class WaterStack extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    path.moveTo(size.width * 0.5, size.height * 0.05);

    path.cubicTo(
      size.width * 0.65,
      size.height * 0.60,
      size.width * 1.05,
      size.height * 0.78,
      size.width * 0.50,
      size.height * 1.00,
    );

    path.cubicTo(
      size.width * -0.05,
      size.height * 0.78,
      size.width * 0.35,
      size.height * 0.60,
      size.width * 0.50,
      size.height * 0.05,
    );

    path.close();

    // Sadece çizgi çiz (içini doldurma)
    final cizgiStili = Paint()
      ..color = Colors.blue.shade200 // renk
      ..style = PaintingStyle.stroke // Sadece çizgi
      ..strokeWidth = 6; // Kalınlık

    canvas.drawPath(path, cizgiStili);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Dalga animasyonu için widget
class WaterWaveFill extends StatefulWidget {
  const WaterWaveFill({super.key});

  @override
  _WaterWaveFillState createState() => _WaterWaveFillState();
}

class _WaterWaveFillState extends State<WaterWaveFill>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    )..repeat();
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
          painter: WavePainter(_controller.value),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double value;
  WavePainter(this.value);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue.shade500
      ..style = PaintingStyle.fill;

    final path = Path();

    double waveHeight = 12; // dalga kıvrımı
    double speed = value * 2 * 3.14;

    path.moveTo(0, size.height * 0.55);

    for (double x = 0; x <= size.width; x++) {
      double y = size.height * 0.55 +
          sin((x / size.width * 2 * 3.14) + speed) * waveHeight;

      path.lineTo(x, y);
    }

    // Alt kısmı doldur
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;
}

// AppBar özel şekil
class AppBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 20);
    path.quadraticBezierTo(
      size.width / 2,
      size.height,
      size.width,
      size.height - 20,
    );
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
