// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'Tagesziel: $ml ml';
  }

  @override
  String get addWater => 'Wasser hinzufügen';

  @override
  String get weeklyTracking => 'Wöchentliche Übersicht';

  @override
  String get home => 'Startseite';

  @override
  String get reminder => 'Erinnerung';

  @override
  String get settings => 'Einstellungen';

  @override
  String get languageSettings => 'Sprache';

  @override
  String get about => 'Über uns';

  @override
  String get feedback => 'Feedback';

  @override
  String get resetApp => 'App zurücksetzen';
}
