// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Chinese (`zh`).
class AppLocalizationsZh extends AppLocalizations {
  AppLocalizationsZh([String locale = 'zh']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return '每日目标：$ml 毫升';
  }

  @override
  String get addWater => '添加水';

  @override
  String get weeklyTracking => '每周跟踪';

  @override
  String get home => '主页';

  @override
  String get reminder => '提醒';

  @override
  String get settings => '设置';

  @override
  String get languageSettings => '语言';

  @override
  String get about => '关于';

  @override
  String get feedback => '反馈';

  @override
  String get resetApp => '重置应用';

  @override
  String get drinkRecommendation => '建议每天平均饮用 2500 毫升水';

  @override
  String get dailyTarget => '您的每日目标 : ';

  @override
  String get todayProgress => '你今天的进度';

  @override
  String get feedbackTitle => '您的反馈对我们非常重要。';

  @override
  String get feedbackContent => 'Muhammet Kaan Turan\n\n您可以将关于应用的意见、建议和投诉发送到此电子邮件地址。所有反馈对我们都非常重要。\nkaannturan@gmail.com';

  @override
  String get drunkWater => '已饮用水量：';

  @override
  String get dailyGoalLabel => '每日目标：';

  @override
  String get remaining => '剩余：';

  @override
  String completedPercent(Object percent) {
    return '已完成 %$percent%';
  }

  @override
  String get weeklyWaterTracking => '每周饮水跟踪';

  @override
  String get enableReminders => '启用提醒';

  @override
  String get dailyReminderDescription => '接收每日饮水提醒';

  @override
  String get reminderTimes => '提醒时间';

  @override
  String get noReminderAdded => '您还没有添加提醒';

  @override
  String get addReminderHint => '点击上方的 + 按钮\n添加新的提醒';

  @override
  String get repeatsDaily => '每天重复';

  @override
  String get languageSelection => '语言选择';

  @override
  String get infoTitle => '信息';

  @override
  String get reminderInfoDescription => '提醒将在您设定的时间每天向您发送通知。规律饮水对您的健康非常重要！💧';

  @override
  String get newBadgeTitle => '🎉 新徽章！';

  @override
  String get goButton => '前往';
}
