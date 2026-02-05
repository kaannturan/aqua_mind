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
    return 'الهدف اليومي: $ml مل';
  }

  @override
  String get addWater => 'إضافة ماء';

  @override
  String get weeklyTracking => 'متابعة أسبوعية';

  @override
  String get home => 'الرئيسية';

  @override
  String get reminder => 'تذكير';

  @override
  String get settings => 'الإعدادات';

  @override
  String get languageSettings => 'اللغة';

  @override
  String get about => 'حول';

  @override
  String get feedback => 'ملاحظات';
}
