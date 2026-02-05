// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return '1日の目標：$ml ml';
  }

  @override
  String get addWater => '水を追加';

  @override
  String get weeklyTracking => '週間トラッキング';

  @override
  String get home => 'ホーム';

  @override
  String get reminder => 'リマインダー';

  @override
  String get settings => '設定';

  @override
  String get languageSettings => '言語';

  @override
  String get about => '情報';

  @override
  String get feedback => 'フィードバック';

  @override
  String get resetApp => 'アプリをリセット';
}
