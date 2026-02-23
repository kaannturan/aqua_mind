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
}
