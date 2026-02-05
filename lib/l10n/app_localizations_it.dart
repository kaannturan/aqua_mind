// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'Obiettivo giornaliero: $ml ml';
  }

  @override
  String get addWater => 'Aggiungi acqua';

  @override
  String get weeklyTracking => 'Monitoraggio settimanale';

  @override
  String get home => 'Home';

  @override
  String get reminder => 'Promemoria';

  @override
  String get settings => 'Impostazioni';

  @override
  String get languageSettings => 'Lingua';

  @override
  String get about => 'Informazioni';

  @override
  String get feedback => 'Feedback';

  @override
  String get resetApp => 'Reimposta app';
}
