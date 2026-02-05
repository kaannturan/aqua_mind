// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'Дневная цель: $ml мл';
  }

  @override
  String get addWater => 'Добавить воду';

  @override
  String get weeklyTracking => 'Недельный отчет';

  @override
  String get home => 'Главная';

  @override
  String get reminder => 'Напоминание';

  @override
  String get settings => 'Настройки';

  @override
  String get languageSettings => 'Язык';

  @override
  String get about => 'О нас';

  @override
  String get feedback => 'Отзыв';
}
