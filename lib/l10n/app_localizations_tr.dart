// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'Günlük hedef: $ml ml';
  }

  @override
  String get addWater => 'Su ekle';

  @override
  String get weeklyTracking => 'Haftalık takip';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get reminder => 'Hatırlatıcı';

  @override
  String get settings => 'Ayarlar';

  @override
  String get languageSettings => 'Dil Ayarları';

  @override
  String get about => 'Hakkımızda';

  @override
  String get feedback => 'Görüşleriniz';
}
