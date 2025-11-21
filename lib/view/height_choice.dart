// ignore_for_file: unused_local_variable, deprecated_member_use

import 'package:aqua_mind/widgets/step_item_gender.dart';
import 'package:flutter/material.dart';

class SizeChoice extends StatefulWidget {
  const SizeChoice({super.key});

  @override
  State<SizeChoice> createState() => _SizeChoiceState();
}

class _SizeChoiceState extends State<SizeChoice> {
  int selectedHeight = 170;
  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(initialItem: 70);
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
          padding: EdgeInsets.symmetric(horizontal: width * 0.05),
          child: Column(
            children: [
              // Üst step indicator
              SizedBox(height: height * 0.02),
              SizedBox(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CircleAvatar(
                      radius: width * 0.02,
                      backgroundColor: Colors.grey,
                    ),
                    StepItemGender(
                      isActive: true,
                      icon: Icons.height_rounded,
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

              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        // Seçim kutusu
                        Container(
                          height: 60,
                          margin: EdgeInsets.symmetric(horizontal: width * 0.2),
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
                              final isSelected = itemHeight == selectedHeight;

                              return Center(
                                child: Text(
                                  "$itemHeight cm",
                                  style: TextStyle(
                                    fontSize: isSelected ? 30 : 24,
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                    color:
                                        isSelected ? Colors.white : Colors.grey,
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
                    );
                  },
                ),
              ),

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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white70,
                          size: width * 0.06,
                        ),
                      ),
                    ),
                    // Devam et butonu
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SizeChoice(),
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
                          color: Colors.white70,
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
