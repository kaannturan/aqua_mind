// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:aqua_mind/models/user_model.dart';
import 'package:aqua_mind/util/daily_calculate.dart';
import 'package:aqua_mind/view/resultpage.dart';
import 'package:aqua_mind/widgets/step_item_gender.dart';
import 'package:flutter/material.dart';

class WeightChoiceView extends StatefulWidget {
  final int height;
  final String gender;
  const WeightChoiceView(
      {super.key, required this.height, required this.gender});

  @override
  State<WeightChoiceView> createState() => _WeightChoiceViewState();
}

class _WeightChoiceViewState extends State<WeightChoiceView> {
  int selectedWeight = 70;
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController =
        FixedExtentScrollController(initialItem: selectedWeight - 30);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController heightController =
        TextEditingController(text: widget.height.toString());
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
                    CircleAvatar(
                      radius: width * 0.02,
                      backgroundColor: Colors.grey,
                    ),
                    StepItemGender(
                      isActive: true,
                      icon: Icons.monitor_weight_outlined,
                      text: "Kilo",
                    ),
                  ],
                ),
              ),

              SizedBox(height: height * 0.02),

              // Başlık
              Text(
                "Kilonuzu Seçiniz",
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
                                  width: constraints.maxWidth * 0.5,
                                  height: constraints.maxHeight * 0.4,
                                  child: AnimatedContainer(
                                    duration:
                                        const Duration(milliseconds: 1000),
                                    curve: Curves.easeInOut,
                                    child: Image.asset(
                                      'assets/images/scale.png',
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
                                    final itemWeight = 30 + index;
                                    final isSelected =
                                        itemWeight == selectedWeight;

                                    return Center(
                                      child: Text(
                                        "$itemWeight kg",
                                        style: TextStyle(
                                          fontSize: isSelected ? 27 : 24,
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
                                    selectedWeight = 30 + value;
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
                          double dailyWater =
                              DailyCalculate.calculateDailyWater(UserModel(
                                  gender: widget.gender,
                                  height: widget.height,
                                  weight: selectedWeight));
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      Result(
                                height: widget.height,
                                weight: selectedWeight,
                                dailyWater: dailyWater,
                              ),
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
                          "Hesapla",
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
