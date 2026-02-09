import 'package:aqua_mind/core/service/notification_service.dart';
import 'package:aqua_mind/core/utils/provider_local.dart';
import 'package:aqua_mind/l10n/app_localizations.dart';
import 'package:aqua_mind/view/hi_view.dart';
import 'package:aqua_mind/view/home_view/home_view.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // AdMob başlat
  await MobileAds.instance.initialize();

  // Bildirim servisini başlat
  await NotificationService().initialize();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final prefs = await SharedPreferences.getInstance();
  final dailyWater = prefs.getDouble("dailyWater") ?? 0.0;
  final isCompleted = prefs.getBool("completedSetup") ?? false;

  final height = (prefs.getDouble("height") ?? 0.0).toInt();
  final weight = (prefs.getDouble("weight") ?? 0.0).toInt();

  runApp(
    ChangeNotifierProvider(
      create: (_) => LocaleProvider(),
      child: DevicePreview(
        enabled: false,
        builder: (context) => AquaMind(
          isCompleted: isCompleted,
          dailyWater: dailyWater,
          height: height,
          weight: weight,
        ),
      ),
    ),
  );
}

class AquaMind extends StatelessWidget {
  final bool isCompleted;
  final double dailyWater;
  final int height;
  final int weight;

  const AquaMind({
    super.key,
    required this.isCompleted,
    required this.dailyWater,
    required this.height,
    required this.weight,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, child) {
        return MaterialApp(
          locale: localeProvider.locale,
          debugShowCheckedModeBanner: false,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: localeProvider.supportedLocales,
          theme: ThemeData(
            textTheme: GoogleFonts.nunitoTextTheme(),
            useMaterial3: true,
          ),
          home: isCompleted
              ? HomePage(
                  dailyWater: dailyWater,
                  height: height,
                  weight: weight,
                )
              : const HiPage(),
        );
      },
    );
  }
}
