// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'दैनिक पानी लक्ष्य: $ml ml';
  }

  @override
  String get addWater => 'पानी जोड़ें';

  @override
  String get weeklyTracking => 'साप्ताहिक ट्रैकिंग';
}
