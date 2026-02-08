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
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

// Bildirim Servisi
class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  factory NotificationService() => _instance;
  NotificationService._internal();

  final FlutterLocalNotificationsPlugin _notifications =
      FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Europe/Istanbul'));

    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const InitializationSettings settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _notifications.initialize(settings);
    await _requestPermissions();
  }

  Future<bool> _requestPermissions() async {
    if (await Permission.notification.isDenied) {
      final status = await Permission.notification.request();
      return status.isGranted;
    }
    return true;
  }

  Future<void> scheduleDailyWaterReminders(List<String> times) async {
    await cancelAllReminders();

    for (int i = 0; i < times.length; i++) {
      await _scheduleWaterReminder(i, times[i]);
    }
  }

  Future<void> _scheduleWaterReminder(int id, String time) async {
    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    await _notifications.zonedSchedule(
      id,
      '💧 Su İçme Zamanı!',
      'Sağlığın için bir bardak su içmeyi unutma!',
      scheduledDate,
      NotificationDetails(
        android: AndroidNotificationDetails(
          'water_reminder_channel',
          'Su Hatırlatıcıları',
          channelDescription: 'Günlük su içme hatırlatıcıları',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: const DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> cancelAllReminders() async {
    await _notifications.cancelAll();
  }

  Future<void> showTestNotification() async {
    await _notifications.show(
      999,
      '💧 Test Bildirimi',
      'Bildirimler çalışıyor!',
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'water_reminder_channel',
          'Su Hatırlatıcıları',
          channelDescription: 'Günlük su içme hatırlatıcıları',
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      ),
    );
  }
}

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
          supportedLocales: const [
            Locale('en'),
            Locale('tr'),
            Locale('es'),
            Locale('de'),
            Locale('fr'),
            Locale('it'),
            Locale('pt'),
            Locale('ru'),
            Locale('zh'),
            Locale('ja'),
            Locale('ko'),
            Locale('ar'),
          ],
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
