// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'الهدف اليومي للماء: $ml مل';
  }

  @override
  String get addWater => 'إضافة ماء';

  @override
  String get weeklyTracking => 'تتبع أسبوعي';
}
