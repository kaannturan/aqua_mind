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

  @override
  String get drinkRecommendation => 'Si consiglia di bere in media 2500 ml di acqua al giorno.';

  @override
  String get dailyTarget => 'Il tuo obiettivo giornaliero : ';

  @override
  String get todayProgress => 'Il tuo progresso di oggi';

  @override
  String get feedbackTitle => 'Il tuo feedback è importante per noi.';

  @override
  String get feedbackContent => 'Muhammet Kaan Turan\n\nPuoi inviare opinioni, suggerimenti e reclami sull\'app a questo indirizzo email. Tutti i feedback sono molto importanti per noi.\nkaannturan@gmail.com';

  @override
  String get drunkWater => 'Acqua consumata:';

  @override
  String get dailyGoalLabel => 'Obiettivo giornaliero:';

  @override
  String get remaining => 'Rimanente:';

  @override
  String completedPercent(Object percent) {
    return '%$percent completato';
  }

  @override
  String get weeklyWaterTracking => 'Monitoraggio settimanale dell\'acqua';

  @override
  String get enableReminders => 'Attiva promemoria';

  @override
  String get dailyReminderDescription => 'Ricevi promemoria giornalieri per bere acqua';

  @override
  String get reminderTimes => 'Orari promemoria';

  @override
  String get noReminderAdded => 'Non hai ancora aggiunto promemoria';

  @override
  String get addReminderHint => 'Tocca il pulsante + sopra\nper aggiungere un nuovo promemoria';

  @override
  String get repeatsDaily => 'Si ripete ogni giorno';

  @override
  String get languageSelection => 'Selezione lingua';

  @override
  String get infoTitle => 'Informazione';

  @override
  String get reminderInfoDescription => 'I promemoria ti invieranno notifiche ogni giorno agli orari impostati. Bere acqua regolarmente è molto importante per la tua salute! 💧';
}
