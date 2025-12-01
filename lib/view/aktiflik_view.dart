import 'package:aqua_mind/widgets/step_item_gender.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AktiflikView extends StatefulWidget {
  const AktiflikView({super.key});

  @override
  State<AktiflikView> createState() => _AktiflikViewState();
}

class _AktiflikViewState extends State<AktiflikView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.12,
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
                  CircleAvatar(
                    radius: width * 0.02,
                    backgroundColor: Colors.grey,
                  ),
                  StepItemGender(
                    isActive: true,
                    icon: Icons.fitness_center,
                    text: "Hareket",
                    selectedColor: Colors.lightBlue,
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
