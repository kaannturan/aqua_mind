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

  @override
  String get drinkRecommendation => 'Il est recommandé de boire en moyenne 2500 ml d\'eau par jour.';

  @override
  String get dailyTarget => 'Votre objectif quotidien : ';

  @override
  String get todayProgress => 'Votre progrès du jour';

  @override
  String get feedbackTitle => 'Votre avis est précieux pour nous.';

  @override
  String get feedbackContent => 'Muhammet Kaan Turan\n\nVous pouvez envoyer vos avis, suggestions et réclamations concernant l\'application à cette adresse e-mail. Tous les retours sont très importants pour nous.\nkaannturan@gmail.com';

  @override
  String get drunkWater => 'Eau consommée :';

  @override
  String get dailyGoalLabel => 'Objectif quotidien :';

  @override
  String get remaining => 'Restant :';

  @override
  String completedPercent(Object percent) {
    return '%$percent terminé';
  }

  @override
  String get weeklyWaterTracking => 'Suivi hebdomadaire de l\'eau';

  @override
  String get enableReminders => 'Enable Reminders';

  @override
  String get dailyReminderDescription => 'Receive daily water drinking reminders';

  @override
  String get reminderTimes => 'Reminder Times';

  @override
  String get noReminderAdded => 'You haven\'t added any reminders yet';

  @override
  String get addReminderHint => 'Tap the + button above\nto add a new reminder';

  @override
  String get repeatsDaily => 'Repeats daily';

  @override
  String get languageSelection => 'Choix de la langue';

  @override
  String get infoTitle => 'Information';

  @override
  String get reminderInfoDescription => 'Les rappels vous enverront des notifications chaque jour aux heures que vous avez définies. Une consommation régulière d’eau est très importante pour votre santé ! 💧';
}
