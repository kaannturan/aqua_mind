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

  @override
  String get drinkRecommendation => '1日に平均2500mlの水を飲むことが推奨されています';

  @override
  String get dailyTarget => '1日の目標 : ';

  @override
  String get todayProgress => '今日の進捗';

  @override
  String get feedbackTitle => 'ご意見は私たちにとって大切です。';

  @override
  String get feedbackContent => 'Muhammet Kaan Turan\n\nアプリに関するご意見・ご提案・ご不満は、このメールアドレスまでお送りください。すべてのフィードバックは私たちにとって非常に重要です。\nkaannturan@gmail.com';

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
  String get enableReminders => 'リマインダーを有効にする';

  @override
  String get dailyReminderDescription => '毎日の水分補給リマインダーを受け取る';

  @override
  String get reminderTimes => 'リマインダー時間';

  @override
  String get noReminderAdded => 'まだリマインダーが追加されていません';

  @override
  String get addReminderHint => '上の + ボタンをタップして\n新しいリマインダーを追加';

  @override
  String get repeatsDaily => '毎日繰り返し';

  @override
  String get languageSelection => '言語選択';

  @override
  String get infoTitle => '情報';

  @override
  String get reminderInfoDescription => 'リマインダーは設定した時間に毎日通知を送信します。定期的な水分補給は健康にとても重要です！💧';

  @override
  String get newBadgeTitle => '🎉 新しいバッジ！';

  @override
  String get goButton => '移動';
}
