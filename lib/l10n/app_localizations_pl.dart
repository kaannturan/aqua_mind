// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'Dzienne spożycie wody: $ml ml';
  }

  @override
  String get addWater => 'Dodaj wodę';

  @override
  String get weeklyTracking => 'Cotygodniowe śledzenie';
}
