import 'package:aqua_mind/view/user_gender_view.dart';
import 'package:flutter/material.dart';

class HiPage extends StatelessWidget {
  const HiPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: width * 0.05,
            vertical: height * 0.02,
          ),
          child: Column(
            children: [
              // Orta kısım - Hoşgeldin metni
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 1600),
                        builder: (context, value, child) => Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, (1 - value) * 20),
                            child: child,
                          ),
                        ),
                        child: Text(
                          """Merhaba, 
AquaMind'a Hoşgeldiniz! """,
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: width * 0.070,
                            color: Colors.white70,
                            fontWeight: FontWeight.bold,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: height * 0.02),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 1700),
                        builder: (context, value, child) => Opacity(
                          opacity: value,
                          child: Transform.translate(
                            offset: Offset(0, (1 - value) * 20),
                            child: child,
                          ),
                        ),
                        child: Text(
                          """
Sağlıklı alışkanlıklar edinmek,
beden ve zihin sağlığınızı güçlendirmek için 
doğru yerdesiniz.""",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: width * 0.042,
                            color: Colors.white70,
                            fontWeight: FontWeight.w100,
                            height: 1.5,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Alt kısım - Devam Et butonu
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const UserGenderPage(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                            const begin = Offset(1.0, 0.0);
                            const end = Offset.zero;
                            const curve = Curves.easeInOut;

                            var tween = Tween(begin: begin, end: end).chain(
                              CurveTween(curve: curve),
                            );

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                          transitionDuration: const Duration(milliseconds: 500),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 10,
                      backgroundColor: Colors.lightBlue,
                      padding: EdgeInsets.symmetric(
                        horizontal: width * 0.07,
                        vertical: height * 0.01,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: Text(
                      "Devam Et",
                      style: TextStyle(
                        fontSize: width * 0.043,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
