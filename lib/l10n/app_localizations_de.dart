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

  @override
  String get drinkRecommendation => 'Es wird empfohlen, täglich durchschnittlich 2500 ml Wasser zu trinken.';

  @override
  String get dailyTarget => 'Ihr tägliches Ziel : ';

  @override
  String get todayProgress => 'Dein heutiger Fortschritt';

  @override
  String get feedbackTitle => 'Ihr Feedback ist uns wichtig.';

  @override
  String get feedbackContent => 'Muhammet Kaan Turan\n\nSie können Ihre Meinungen, Vorschläge und Beschwerden über die App an diese E-Mail-Adresse senden. Jedes Feedback ist für uns sehr wertvoll.\nkaannturan@gmail.com';

  @override
  String get drunkWater => 'Getrunkenes Wasser:';

  @override
  String get dailyGoalLabel => 'Tagesziel:';

  @override
  String get remaining => 'Verbleibend:';

  @override
  String completedPercent(Object percent) {
    return '%$percent abgeschlossen';
  }

  @override
  String get weeklyWaterTracking => 'Wöchentliche Wasserverfolgung';

  @override
  String get enableReminders => 'Erinnerungen aktivieren';

  @override
  String get dailyReminderDescription => 'Tägliche Trink-Erinnerungen erhalten';

  @override
  String get reminderTimes => 'Erinnerungszeiten';

  @override
  String get noReminderAdded => 'Sie haben noch keine Erinnerung hinzugefügt';

  @override
  String get addReminderHint => 'Tippen Sie oben auf +,\num eine neue Erinnerung hinzuzufügen';

  @override
  String get repeatsDaily => 'Wird täglich wiederholt';

  @override
  String get languageSelection => 'Sprachauswahl';

  @override
  String get infoTitle => 'Information';

  @override
  String get reminderInfoDescription => 'Erinnerungen senden Ihnen täglich zu den festgelegten Zeiten Benachrichtigungen. Regelmäßige Wasseraufnahme ist sehr wichtig für Ihre Gesundheit! 💧';

  @override
  String get newBadgeTitle => '🎉 Neues Abzeichen!';

  @override
  String get goButton => 'Los';
}
