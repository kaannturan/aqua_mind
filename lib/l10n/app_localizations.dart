import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ko.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_tr.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('ja'),
    Locale('ko'),
    Locale('pt'),
    Locale('ru'),
    Locale('tr'),
    Locale('zh')
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'AquaMind'**
  String get appTitle;

  /// Daily water goal with ml value
  ///
  /// In en, this message translates to:
  /// **'Daily goal: {ml} ml'**
  String home_dailyGoal(Object ml);

  /// No description provided for @addWater.
  ///
  /// In en, this message translates to:
  /// **'Add water'**
  String get addWater;

  /// No description provided for @weeklyTracking.
  ///
  /// In en, this message translates to:
  /// **'Weekly tracking'**
  String get weeklyTracking;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @reminder.
  ///
  /// In en, this message translates to:
  /// **'Reminder'**
  String get reminder;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @languageSettings.
  ///
  /// In en, this message translates to:
  /// **'Language Settings'**
  String get languageSettings;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @feedback.
  ///
  /// In en, this message translates to:
  /// **'Feedback'**
  String get feedback;

  /// No description provided for @resetApp.
  ///
  /// In en, this message translates to:
  /// **'Reset App'**
  String get resetApp;

  /// No description provided for @drinkRecommendation.
  ///
  /// In en, this message translates to:
  /// **'It is recommended to drink an average of 2500 ml of water per day.'**
  String get drinkRecommendation;

  /// No description provided for @dailyTarget.
  ///
  /// In en, this message translates to:
  /// **'Your daily target : '**
  String get dailyTarget;

  /// No description provided for @todayProgress.
  ///
  /// In en, this message translates to:
  /// **'Your progress today'**
  String get todayProgress;

  /// No description provided for @feedbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Your feedback is valuable to us.'**
  String get feedbackTitle;

  /// No description provided for @feedbackContent.
  ///
  /// In en, this message translates to:
  /// **'Muhammet Kaan Turan\n\nYou can send your opinions, suggestions and complaints about the application to this email address. All feedback is very important to us.\nkaannturan@gmail.com'**
  String get feedbackContent;

  /// No description provided for @drunkWater.
  ///
  /// In en, this message translates to:
  /// **'Water Consumed:'**
  String get drunkWater;

  /// No description provided for @dailyGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Daily Goal:'**
  String get dailyGoalLabel;

  /// No description provided for @remaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining:'**
  String get remaining;

  /// No description provided for @completedPercent.
  ///
  /// In en, this message translates to:
  /// **'%{percent} completed'**
  String completedPercent(Object percent);

  /// No description provided for @weeklyWaterTracking.
  ///
  /// In en, this message translates to:
  /// **'Weekly Water Tracking'**
  String get weeklyWaterTracking;

  /// No description provided for @enableReminders.
  ///
  /// In en, this message translates to:
  /// **'Enable Reminders'**
  String get enableReminders;

  /// No description provided for @dailyReminderDescription.
  ///
  /// In en, this message translates to:
  /// **'Receive daily water drinking reminders'**
  String get dailyReminderDescription;

  /// No description provided for @reminderTimes.
  ///
  /// In en, this message translates to:
  /// **'Reminder Times'**
  String get reminderTimes;

  /// No description provided for @noReminderAdded.
  ///
  /// In en, this message translates to:
  /// **'You haven\'t added any reminders yet'**
  String get noReminderAdded;

  /// No description provided for @addReminderHint.
  ///
  /// In en, this message translates to:
  /// **'Tap the + button above\nto add a new reminder'**
  String get addReminderHint;

  /// No description provided for @repeatsDaily.
  ///
  /// In en, this message translates to:
  /// **'Repeats daily'**
  String get repeatsDaily;

  /// No description provided for @languageSelection.
  ///
  /// In en, this message translates to:
  /// **'Language Selection'**
  String get languageSelection;

  /// No description provided for @infoTitle.
  ///
  /// In en, this message translates to:
  /// **'Information'**
  String get infoTitle;

  /// No description provided for @reminderInfoDescription.
  ///
  /// In en, this message translates to:
  /// **'Reminders will send you notifications every day at the times you set. Regular water intake is very important for your health! 💧'**
  String get reminderInfoDescription;

  /// No description provided for @newBadgeTitle.
  ///
  /// In en, this message translates to:
  /// **'🎉 New Badge!'**
  String get newBadgeTitle;

  /// No description provided for @goButton.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get goButton;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['ar', 'de', 'en', 'es', 'fr', 'it', 'ja', 'ko', 'pt', 'ru', 'tr', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar': return AppLocalizationsAr();
    case 'de': return AppLocalizationsDe();
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
    case 'fr': return AppLocalizationsFr();
    case 'it': return AppLocalizationsIt();
    case 'ja': return AppLocalizationsJa();
    case 'ko': return AppLocalizationsKo();
    case 'pt': return AppLocalizationsPt();
    case 'ru': return AppLocalizationsRu();
    case 'tr': return AppLocalizationsTr();
    case 'zh': return AppLocalizationsZh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
