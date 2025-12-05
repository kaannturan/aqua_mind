// ignore_for_file: deprecated_member_use, use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'home_view/home_view.dart';

class LoadingPage extends StatefulWidget {
  final int height;
  final int weight;
  final double dailyWater;

  const LoadingPage({
    super.key,
    required this.height,
    required this.weight,
    required this.dailyWater,
  });

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();

    // Bekleme + yönlendirme
    Future.delayed(const Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(
            height: widget.height,
            weight: widget.weight,
            dailyWater: widget.dailyWater,
          ),
        ),
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
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color(0xff062549),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.black,
              Color(0xff062549),
              Color(0xff062549),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            // DALGA ANİMASYONU
            AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                return CustomPaint(
                  size: size,
                  painter: WavePainter(_controller.value),
                );
              },
            ),

            // YAZI & LOGO
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.water_drop, color: Colors.white, size: 70),
                  const SizedBox(height: 20),
                  Text(
                    "Hesaplama Yapılıyor..",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: size.width * 0.06,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final double animationValue;

  WavePainter(this.animationValue);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.blue.withOpacity(0.4);

    final path = Path();

    double yOffset = size.height * 0.75;

    path.moveTo(0, yOffset);

    for (double x = 0; x <= size.width; x++) {
      double y = sin((x / size.width * 2 * pi) + animationValue * 2 * pi) * 20;
      path.lineTo(x, y + yOffset);
    }

    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(WavePainter oldDelegate) => true;
}
