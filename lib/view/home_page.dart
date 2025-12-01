// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, unused_local_variable

import 'dart:math';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  final int height;
  final int weight;
  final double dailyWater;
  const HomePage(
      {super.key,
      required this.dailyWater,
      required this.height,
      required this.weight});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double waterLevel = 0.9; // Su seviyesi (0.0 - 1.0)
  int currentWater = 00; // Mevcut su miktarı (ml)
  late int targetWater; // Hedef su miktarı (ml)
  late double liter;

  @override
  void initState() {
    super.initState();
    targetWater = widget.dailyWater.toInt();
    liter = widget.dailyWater / 1000;
  }

  void addWater(int amount) {
    setState(() {
      int newWater = currentWater + amount;

      if (currentWater >= targetWater) {
        return;
      }

      currentWater = (currentWater + amount).clamp(0, targetWater);
      waterLevel = 1.0 - (currentWater / targetWater * 0.85);
      waterLevel = waterLevel.clamp(0.15, 1.0);
    });
  }

  void removeWater(int amount) {
    setState(() {
      currentWater = (currentWater - amount).clamp(0, targetWater);
      waterLevel = 1.0 - (currentWater / targetWater * 0.85);
      waterLevel = waterLevel.clamp(0.15, 1.0);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white70),
        backgroundColor: Color(0xff062549),
        elevation: 0,
        title: Text(
          "AquaMind",
          style: TextStyle(
            color: Colors.white70,
            fontSize: width * 0.06,
            fontWeight: FontWeight.bold,
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
                leading: Icon(FontAwesomeIcons.solidBell),
                title: Text('Hatırlatıcı'),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Ayarlar'),
              ),
              ListTile(
                leading: Icon(Icons.mail),
                title: Text('Görüşleriniz'),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text('Hakkımızda'),
              ),
              SizedBox(height: height * 0.48),
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
                      size: width * 0.04,
                    ),
                    SizedBox(width: width * 0.02),
                    Text(
                      "İyi Günler",
                      style: TextStyle(
                        fontSize: width * 0.04,
                        color: Colors.white70,
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
                          child: WaterWaveFill(waterLevel: waterLevel),
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
              Text(
                "  $currentWater / $targetWater ml   ",
                style: TextStyle(color: Colors.white70),
              ),
              SizedBox(
                height: height * 0.016,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Günlük Hedefiniz : $targetWater ml",
                    style: TextStyle(
                      fontSize: width * 0.04,
                      color: Colors.white70,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.05),
              Container(
                width: width * 0.9,
                height: height * 0.099,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: currentWater >= targetWater
                            ? null
                            : () => addWater(100),
                        borderRadius: BorderRadius.circular(60),
                        child: Container(
                          width: width * 0.15,
                          height: height * 0.08,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                Colors.blue,
                                Colors.blue,
                              ],
                            ),
                            shape: BoxShape.circle,
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
                                "100 ml",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
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
                        onTap: currentWater >= targetWater
                            ? null
                            : () => addWater(200),
                        borderRadius: BorderRadius.circular(60),
                        child: Container(
                          width: width * 0.15,
                          height: height * 0.08,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: AlignmentGeometry.topLeft,
                              end: AlignmentGeometry.bottomRight,
                              colors: [
                                Colors.blue,
                                Colors.blue,
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.wineGlass,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "200 ml",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
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
                        onTap: currentWater >= targetWater
                            ? null
                            : () => addWater(500),
                        borderRadius: BorderRadius.circular(60),
                        child: Container(
                          width: width * 0.15,
                          height: height * 0.08,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                Colors.blue,
                                Colors.blue,
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.bottleDroplet,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "500 ml",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
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
                        borderRadius: BorderRadius.circular(60),
                        onTap: () => removeWater(100),
                        child: Container(
                          width: width * 0.15,
                          height: height * 0.08,
                          decoration: BoxDecoration(
                            gradient: RadialGradient(
                              colors: [
                                Colors.red,
                                Colors.red,
                              ],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.downLong,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(height: 8),
                              Text(
                                "100 ml",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.5,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.010,
              ),

              // bilgiler container
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(27)),
                width: width * 0.9,
                height: height / 3,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                          "Günlük su Miktarınız hem zihin berraklığınız için hem de zinde olmanız için çok önemlidir"),
                    )
                  ],
                ),
              ),
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

    final cizgiStili = Paint()
      ..color = Colors.blue.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawPath(path, cizgiStili);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Dalga animasyonu için widget
class WaterWaveFill extends StatefulWidget {
  final double waterLevel;

  const WaterWaveFill({super.key, required this.waterLevel});

  @override
  _WaterWaveFillState createState() => _WaterWaveFillState();
}

class _WaterWaveFillState extends State<WaterWaveFill>
    with TickerProviderStateMixin {
  late AnimationController _backController;
  late AnimationController _frontController;
  late AnimationController _levelController;
  late Animation<double> _levelAnimation;

  double _currentLevel = 0.9;

  @override
  void initState() {
    super.initState();
    _backController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();

    _frontController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat();

    _levelController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _levelAnimation = Tween<double>(
      begin: _currentLevel,
      end: widget.waterLevel,
    ).animate(CurvedAnimation(
      parent: _levelController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(WaterWaveFill oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.waterLevel != widget.waterLevel) {
      double startlevel =
          _levelController.isAnimating ? _levelAnimation.value : _currentLevel;

      _levelAnimation = Tween<double>(
        begin: startlevel,
        end: widget.waterLevel,
      ).animate(CurvedAnimation(
        parent: _levelController,
        curve: Curves.easeInOut,
      ));

      _levelController.reset();
      _levelController.forward().then((_) {
        _currentLevel = widget.waterLevel;
      });
    }
  }

  @override
  void dispose() {
    _backController.dispose();
    _frontController.dispose();
    _levelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(
          [_backController, _frontController, _levelAnimation]),
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(
            _backController.value,
            _frontController.value,
            _levelAnimation.value,
          ),
        );
      },
    );
  }
}

class WavePainter extends CustomPainter {
  final double backValue;
  final double frontValue;
  final double waterLevel;

  WavePainter(this.backValue, this.frontValue, this.waterLevel);

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.white,
          Colors.blue.shade200,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final shadowPaint = Paint()
      ..color = Colors.blue.shade900.withOpacity(0.25)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 15);

    final backWavePaint = Paint()
      ..color = Colors.blue.shade400.withOpacity(0.6)
      ..style = PaintingStyle.fill;

    final frontWavePaint = Paint()
      ..color = Colors.blue.shade600.withOpacity(0.8)
      ..style = PaintingStyle.fill;

    double baseHeight = size.height * waterLevel;

    double backPhase = backValue * 2 * 3.14;
    double frontPhase = frontValue * 2 * 3.14;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final backWave = Path()..moveTo(0, baseHeight);
    for (double x = 0; x <= size.width; x++) {
      double y = baseHeight + sin((x / size.width * 2 * 3.14) + backPhase) * 14;
      backWave.lineTo(x, y);
    }
    backWave.lineTo(size.width, size.height);
    backWave.lineTo(0, size.height);
    backWave.close();

    canvas.drawPath(backWave, shadowPaint);
    canvas.drawPath(backWave, backWavePaint);

    final frontWave = Path()..moveTo(0, baseHeight - 8);
    for (double x = 0; x <= size.width; x++) {
      double y =
          (baseHeight - 8) + sin((x / size.width * 2 * 3.14) + frontPhase) * 14;
      frontWave.lineTo(x, y);
    }
    frontWave.lineTo(size.width, size.height);
    frontWave.lineTo(0, size.height);
    frontWave.close();

    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawPath(frontWave, frontWavePaint);
    canvas.drawPath(frontWave, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) => true;
}
