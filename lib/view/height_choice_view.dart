// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:aqua_mind/view/weight_choice_view.dart';
import 'package:aqua_mind/widgets/step_item_gender.dart';
import 'package:flutter/material.dart';

class HeightChoiceView extends StatefulWidget {
  const HeightChoiceView({super.key});

  @override
  State<HeightChoiceView> createState() => _HeightChoiceViewState();
}

// Class içinde helper metod ekleyin
double _calculateImageHeight(int height, double maxHeight) {
  // 100 cm = Minimum görsel yüksekliği (ekranın %40'ı)
  // 250 cm = Maksimum görsel yüksekliği (ekranın %85'i)
  double minSize = maxHeight * 0.40;
  double maxSize = maxHeight * 0.85;

  // Boy oranını hesapla (100-250 cm arasında)
  double ratio = (height - 100) / (250 - 100);

  // Boyutu orantılı olarak hesapla
  return minSize + (ratio * (maxSize - minSize));
}

class _HeightChoiceViewState extends State<HeightChoiceView> {
  int selectedHeight = 170;
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController =
        FixedExtentScrollController(initialItem: selectedHeight - 100);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

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
          ),
          child: Column(
            children: [
              SizedBox(height: height * 0.02),

              // Üst step indicators
              SizedBox(
                height: height * 0.09,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: width * 0.02,
                      backgroundColor: Colors.grey,
                    ),
                    StepItemGender(
                      isActive: true,
                      icon: Icons.height_outlined,
                      text: "Boy",
                    ),
                    CircleAvatar(
                      radius: width * 0.02,
                      backgroundColor: Colors.grey,
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),

              // Başlık
              Text(
                "Boyunuzu Seçiniz",
                style: TextStyle(
                  fontSize: width * 0.065,
                  fontWeight: FontWeight.bold,
                  color: Colors.white70,
                ),
              ),

              SizedBox(height: height * 0.02),

              // Scroll bölümü - Resim + Scroll
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Row(
                      children: [
                        // Sol taraf - Animasyonlu Karakter/Icon
                        Expanded(
                          flex: 1,
                          child: Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(height: 20),

                                // Animasyonlu icon (görsel yerine)
                                SizedBox(
                                  width: constraints.maxWidth * 0.9,
                                  height: constraints.maxHeight * 0.5,
                                  child: AnimatedContainer(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.easeInOut,
                                    height: _calculateImageHeight(
                                      selectedHeight,
                                      constraints.maxHeight,
                                    ),
                                    child: Image.asset(
                                      "assets/images/mutre.png",
                                      filterQuality: FilterQuality.high,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Sağ taraf - Scroll View
                        Expanded(
                          flex: 1,
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              // Seçim kutusu
                              Container(
                                height: 60,
                                margin: EdgeInsets.symmetric(
                                  horizontal: width * 0.05,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.blue.withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(27),
                                  border: Border.all(
                                    color: Colors.lightBlue,
                                  ),
                                ),
                              ),

                              // Scroll view
                              ListWheelScrollView.useDelegate(
                                controller: _scrollController,
                                itemExtent: 60,
                                diameterRatio: 1.5,
                                perspective: 0.005,
                                physics: const FixedExtentScrollPhysics(),
                                childDelegate: ListWheelChildBuilderDelegate(
                                  builder: (context, index) {
                                    final itemHeight = 100 + index;
                                    final isSelected =
                                        itemHeight == selectedHeight;

                                    return Center(
                                      child: Text(
                                        "$itemHeight cm",
                                        style: TextStyle(
                                          fontSize: isSelected ? 30 : 24,
                                          fontWeight: isSelected
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.grey,
                                        ),
                                      ),
                                    );
                                  },
                                  childCount: 151,
                                ),
                                onSelectedItemChanged: (value) {
                                  setState(() {
                                    selectedHeight = 100 + value;
                                  });
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // Butonlar
              Padding(
                padding: EdgeInsets.symmetric(vertical: height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Geri butonu
                    RawMaterialButton(
                      elevation: 10,
                      fillColor: Colors.lightBlue,
                      constraints: BoxConstraints.tightFor(
                        width: width * 0.15,
                        height: width * 0.15,
                      ),
                      shape: const CircleBorder(),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: width * 0.06,
                      ),
                    ),

                    // Hesapla butonu
                    Flexible(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const WeightChoiceView(),
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
                              transitionDuration:
                                  const Duration(milliseconds: 500),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          elevation: 10,
                          backgroundColor: Colors.lightBlue,
                          padding: EdgeInsets.symmetric(
                            horizontal: width * 0.08,
                            vertical: height * 0.018,
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
