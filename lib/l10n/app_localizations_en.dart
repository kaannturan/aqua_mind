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

  @override
  String get resetApp => 'Reset App';

  @override
  String get drinkRecommendation => 'It is recommended to drink an average of 2500 ml of water per day.';

  @override
  String get dailyTarget => 'Your daily target : ';

  @override
  String get todayProgress => 'Your progress today';

  @override
  String get feedbackTitle => 'Your feedback is valuable to us.';

  @override
  String get feedbackContent => 'Muhammet Kaan Turan\n\nYou can send your opinions, suggestions and complaints about the application to this email address. All feedback is very important to us.\nkaannturan@gmail.com';

  @override
  String get drunkWater => 'Water Consumed:';

  @override
  String get dailyGoalLabel => 'Daily Goal:';

  @override
  String get remaining => 'Remaining:';

  @override
  String completedPercent(Object percent) {
    return '%$percent completed';
  }

  @override
  String get weeklyWaterTracking => 'Weekly Water Tracking';

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
  String get languageSelection => 'Language Selection';

  @override
  String get infoTitle => 'Information';

  @override
  String get reminderInfoDescription => 'Reminders will send you notifications every day at the times you set. Regular water intake is very important for your health! 💧';

  @override
  String get newBadgeTitle => '🎉 New Badge!';

  @override
  String get goButton => 'Go';

  @override
  String get badge_first_drop_name => 'First Drop';

  @override
  String get badge_first_drop_desc => 'You used the app for the first time';

  @override
  String get badge_blue_spark_name => 'Blue Spark';

  @override
  String get badge_blue_spark_desc => 'You completed your daily goal for the first time';

  @override
  String get badge_flow_starter_name => 'Flow Starter';

  @override
  String get badge_flow_starter_desc => 'Completed your goal 5 days in a row';

  @override
  String get badge_blue_energy_name => 'Blue Energy';

  @override
  String get badge_blue_energy_desc => 'Drank water regularly for a week';

  @override
  String get badge_water_hunter_name => 'Water Hunter';

  @override
  String get badge_water_hunter_desc => 'Logged data for 15 days';

  @override
  String get badge_hydro_master_name => 'Hydro Master';

  @override
  String get badge_hydro_master_desc => 'Logged data for 1 month';

  @override
  String get badge_ocean_bender_name => 'Ocean King';

  @override
  String get badge_ocean_bender_desc => 'Logged data for 3 months';

  @override
  String get badge_aqua_legend_name => 'Aqua Legend';

  @override
  String get badge_aqua_legend_desc => 'Logged data for 6 months';

  @override
  String get weekDayMon => 'Mon';

  @override
  String get weekDayTue => 'Tue';

  @override
  String get weekDayWed => 'Wed';

  @override
  String get weekDayThu => 'Thu';

  @override
  String get weekDayFri => 'Fri';

  @override
  String get weekDaySat => 'Sat';

  @override
  String get weekDaySun => 'Sun';

  @override
  String get add_reminder => 'Add Reminder';

  @override
  String get swipe_to_select_time => 'Swipe to select time';

  @override
  String get hour => 'HOUR';

  @override
  String get minute => 'MINUTE';

  @override
  String get cancel => 'Cancel';

  @override
  String get add => 'Add';
}
