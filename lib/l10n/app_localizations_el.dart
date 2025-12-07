// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Modern Greek (`el`).
class AppLocalizationsEl extends AppLocalizations {
  AppLocalizationsEl([String locale = 'el']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'Ημερήσιος στόχος νερού: $ml ml';
  }

  @override
  String get addWater => 'Προσθήκη νερού';

  @override
  String get weeklyTracking => 'Εβδομαδιαία παρακολούθηση';
}
