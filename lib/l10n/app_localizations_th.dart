// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Thai (`th`).
class AppLocalizationsTh extends AppLocalizations {
  AppLocalizationsTh([String locale = 'th']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'เป้าหมายน้ำต่อวัน: $ml มล.';
  }

  @override
  String get addWater => 'เพิ่มน้ำ';

  @override
  String get weeklyTracking => 'การติดตามรายสัปดาห์';
}
