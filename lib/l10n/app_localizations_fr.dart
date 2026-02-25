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
  String get drinkRecommendation => 'Il est recommandé de boire en moyenne 2500 ml d\'eau par jour 🙂';

  @override
  String get dailyTarget => 'Votre objectif quotidien :';

  @override
  String get todayProgress => 'Votre progression aujourd\'hui :';

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
  String get enableReminders => 'Activer les rappels';

  @override
  String get dailyReminderDescription => 'Recevoir des rappels quotidiens pour boire de l\'eau';

  @override
  String get reminderTimes => 'Heures de rappel';

  @override
  String get noReminderAdded => 'Vous n\'avez pas encore ajouté de rappel';

  @override
  String get addReminderHint => 'Appuyez sur le bouton + ci-dessus\npour ajouter un nouveau rappel';

  @override
  String get repeatsDaily => 'Répété quotidiennement';

  @override
  String get languageSelection => 'Choix de la langue';

  @override
  String get infoTitle => 'Information';

  @override
  String get reminderInfoDescription => 'Les rappels vous enverront des notifications chaque jour aux heures que vous avez définies. Une consommation régulière d’eau est très importante pour votre santé ! 💧';

  @override
  String get newBadgeTitle => '🎉 Nouveau badge !';

  @override
  String get goButton => 'Aller';

  @override
  String get badge_first_drop_name => 'Première Goutte';

  @override
  String get badge_first_drop_desc => 'Vous avez utilisé l\'application pour la première fois';

  @override
  String get badge_blue_spark_name => 'Étincelle Bleue';

  @override
  String get badge_blue_spark_desc => 'Vous avez atteint votre objectif quotidien pour la première fois';

  @override
  String get badge_flow_starter_name => 'Début de Flux';

  @override
  String get badge_flow_starter_desc => 'Objectif atteint 5 jours consécutifs';

  @override
  String get badge_blue_energy_name => 'Énergie Bleue';

  @override
  String get badge_blue_energy_desc => 'Vous avez bu régulièrement de l\'eau pendant une semaine';

  @override
  String get badge_water_hunter_name => 'Chasseur d’Eau';

  @override
  String get badge_water_hunter_desc => 'Données enregistrées pendant 15 jours';

  @override
  String get badge_hydro_master_name => 'Maître Hydro';

  @override
  String get badge_hydro_master_desc => 'Données enregistrées pendant 1 mois';

  @override
  String get badge_ocean_bender_name => 'Roi des Océans';

  @override
  String get badge_ocean_bender_desc => 'Données enregistrées pendant 3 mois';

  @override
  String get badge_aqua_legend_name => 'Légende Aqua';

  @override
  String get badge_aqua_legend_desc => 'Données enregistrées pendant 6 mois';

  @override
  String get weekDayMon => 'Lun';

  @override
  String get weekDayTue => 'Mar';

  @override
  String get weekDayWed => 'Mer';

  @override
  String get weekDayThu => 'Jeu';

  @override
  String get weekDayFri => 'Ven';

  @override
  String get weekDaySat => 'Sam';

  @override
  String get weekDaySun => 'Dim';

  @override
  String get add_reminder => 'Ajouter un rappel';

  @override
  String get swipe_to_select_time => 'Faites glisser pour choisir l\'heure';

  @override
  String get hour => 'Heure';

  @override
  String get minute => 'Minute';

  @override
  String get cancel => 'Annuler';

  @override
  String get add => 'Ajouter';
}
