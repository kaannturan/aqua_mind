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
  String get drinkRecommendation => '1日に平均2500mlの水を飲むことが推奨されています 🙂';

  @override
  String get dailyTarget => '1日の目標 :';

  @override
  String get todayProgress => '今日の進捗 :';

  @override
  String get feedbackTitle => 'ご意見は私たちにとって大切です。';

  @override
  String get feedbackContent => 'Muhammet Kaan Turan\n\nアプリに関するご意見・ご提案・ご不満は、このメールアドレスまでお送りください。すべてのフィードバックは非常に重要です。\nkaannturan@gmail.com';

  @override
  String get drunkWater => '飲んだ水 :';

  @override
  String get dailyGoalLabel => '1日の目標 :';

  @override
  String get remaining => '残り :';

  @override
  String completedPercent(Object percent) {
    return '%$percent 完了';
  }

  @override
  String get weeklyWaterTracking => '週間の水分追跡';

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

  @override
  String get badge_first_drop_name => '最初の一滴';

  @override
  String get badge_first_drop_desc => '初めてアプリを使用しました';

  @override
  String get badge_blue_spark_name => 'ブルースパーク';

  @override
  String get badge_blue_spark_desc => '初めて1日の目標を達成しました';

  @override
  String get badge_flow_starter_name => 'フロースターター';

  @override
  String get badge_flow_starter_desc => '5日連続で目標達成';

  @override
  String get badge_blue_energy_name => 'ブルーエネルギー';

  @override
  String get badge_blue_energy_desc => '1週間、定期的に水を飲みました';

  @override
  String get badge_water_hunter_name => 'ウォーターハンター';

  @override
  String get badge_water_hunter_desc => '15日間データを記録しました';

  @override
  String get badge_hydro_master_name => 'ハイドロマスター';

  @override
  String get badge_hydro_master_desc => '1か月間データを記録しました';

  @override
  String get badge_ocean_bender_name => 'オーシャンキング';

  @override
  String get badge_ocean_bender_desc => '3か月間データを記録しました';

  @override
  String get badge_aqua_legend_name => 'アクアレジェンド';

  @override
  String get badge_aqua_legend_desc => '6か月間データを記録しました';

  @override
  String get weekDayMon => '月';

  @override
  String get weekDayTue => '火';

  @override
  String get weekDayWed => '水';

  @override
  String get weekDayThu => '木';

  @override
  String get weekDayFri => '金';

  @override
  String get weekDaySat => '土';

  @override
  String get weekDaySun => '日';

  @override
  String get add_reminder => 'リマインダーを追加';

  @override
  String get swipe_to_select_time => 'スワイプして時間を選択';

  @override
  String get hour => '時間';

  @override
  String get minute => '分';

  @override
  String get cancel => 'キャンセル';

  @override
  String get add => '追加';
}
