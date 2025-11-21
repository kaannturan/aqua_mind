import 'package:aqua_mind/view/height_choice.dart';
import 'package:aqua_mind/widgets/custom_gender_container.dart';
import 'package:aqua_mind/widgets/step_item_gender.dart';
import 'package:flutter/material.dart';

class UserGenderPage extends StatefulWidget {
  const UserGenderPage({super.key});

  @override
  State<UserGenderPage> createState() => _UserGenderPageState();
}

class _UserGenderPageState extends State<UserGenderPage> {
  String selectedGender = "Erkek";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              SizedBox(height: height * 0.02),

              // Üst step indicators
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StepItemGender(
                      isActive: true,
                      icon:
                          selectedGender == "Erkek" ? Icons.male : Icons.female,
                      text: selectedGender,
                      selectedColor: selectedGender == "Erkek"
                          ? Colors.lightBlue
                          : Colors.pinkAccent,
                    ),
                    CircleAvatar(
                      radius: width * 0.02,
                      backgroundColor: Colors.grey,
                    ),
                    CircleAvatar(
                      radius: width * 0.02,
                      backgroundColor: Colors.grey,
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.03),

              // Başlık animasyonuu
              TweenAnimationBuilder<double>(
                duration: const Duration(milliseconds: 800),
                tween: Tween(begin: 0.0, end: 1.0),
                curve: Curves.easeOut,
                builder: (context, value, child) {
                  return Opacity(
                    opacity: value,
                    child: Transform.translate(
                      offset: Offset(0, 30 * (1 - value)),
                      child: child,
                    ),
                  );
                },
                child: Text(
                  "Cinsiyetiniz",
                  style: TextStyle(
                    fontSize: width * 0.065,
                    color: Colors.black87,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              // Cinsiyet seçenekleri
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomContainerGender(
                      image: "assets/images/male.png",
                      label: "Erkek",
                      isSelected: selectedGender == "Erkek",
                      selectedColor: Colors.lightBlue,
                      onTap: () => setState(() {
                        selectedGender = "Erkek";
                      }),
                    ),
                    SizedBox(width: width * 0.05),
                    CustomContainerGender(
                      image: "assets/images/female.png",
                      label: "Kadın",
                      isSelected: selectedGender == "Kadın",
                      selectedColor: Colors.pinkAccent,
                      onTap: () => setState(() {
                        selectedGender = "Kadın";
                      }),
                    ),
                  ],
                ),
              ),

              // Alt butonlar
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Geri butonu
                    SizedBox(
                      width: width * 0.12,
                      height: width * 0.12,
                      child: FloatingActionButton(
                        heroTag: "back_button",
                        elevation: 10,
                        backgroundColor: Colors.lightBlue,
                        shape: const CircleBorder(),
                        onPressed: () {},
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: width * 0.06,
                        ),
                      ),
                    ),

                    // Devam butonu
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      SizeChoice(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
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
                              transitionDuration: Duration(milliseconds: 500)),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        elevation: 10,
                        backgroundColor: Colors.lightBlue,
                        padding: EdgeInsets.symmetric(
                          horizontal: width * 0.06,
                          vertical: height * 0.02,
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}
