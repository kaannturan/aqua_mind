// ignore_for_file: unused_import
import 'package:aqua_mind/view/aktiflik_view.dart';
import 'package:aqua_mind/view/height_choice_view.dart';
import 'package:aqua_mind/view/hi_view.dart';
import 'package:aqua_mind/view/home_page.dart';
import 'package:aqua_mind/view/user_gender_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    DevicePreview(
      enabled: false,
      builder: (context) => AquaMind(),
    ),
  );
}

class AquaMind extends StatelessWidget {
  const AquaMind({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue,
        scaffoldBackgroundColor: Color(0xFF062549),
        textTheme: GoogleFonts.nunitoTextTheme(),
        useMaterial3: true,
      ),
      home: const HiPage(),
    );
  }
}

//Color(0xFF062549) lacivert arka plan
