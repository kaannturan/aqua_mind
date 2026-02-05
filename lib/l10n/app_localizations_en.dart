// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'Daily goal: $ml ml';
  }

  @override
  String get addWater => 'Add water';

  @override
  String get weeklyTracking => 'Weekly tracking';

  @override
  String get home => 'Home';

  @override
  String get reminder => 'Reminder';

  @override
  String get settings => 'Settings';

  @override
  String get languageSettings => 'Language Settings';

  @override
  String get about => 'About';

  @override
  String get feedback => 'Feedback';
}
