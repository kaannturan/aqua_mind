// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'Objectif quotidien : $ml ml';
  }

  @override
  String get addWater => 'Ajouter de l\'eau';

  @override
  String get weeklyTracking => 'Suivi hebdomadaire';

  @override
  String get home => 'Accueil';

  @override
  String get reminder => 'Rappel';

  @override
  String get settings => 'Paramètres';

  @override
  String get languageSettings => 'Langue';

  @override
  String get about => 'À propos';

  @override
  String get feedback => 'Retour';

  @override
  String get resetApp => 'Réinitialiser l\'application';
}
