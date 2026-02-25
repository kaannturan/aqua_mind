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

  @override
  String get badge_first_drop_name => '第一滴';

  @override
  String get badge_first_drop_desc => '你第一次使用了该应用';

  @override
  String get badge_blue_spark_name => '蓝色火花';

  @override
  String get badge_blue_spark_desc => '你第一次完成每日目标';

  @override
  String get badge_flow_starter_name => '流动开启者';

  @override
  String get badge_flow_starter_desc => '连续5天完成目标';

  @override
  String get badge_blue_energy_name => '蓝色能量';

  @override
  String get badge_blue_energy_desc => '连续一周规律喝水';

  @override
  String get badge_water_hunter_name => '饮水猎人';

  @override
  String get badge_water_hunter_desc => '记录数据15天';

  @override
  String get badge_hydro_master_name => '水之大师';

  @override
  String get badge_hydro_master_desc => '记录数据1个月';

  @override
  String get badge_ocean_bender_name => '海洋之王';

  @override
  String get badge_ocean_bender_desc => '记录数据3个月';

  @override
  String get badge_aqua_legend_name => '水之传奇';

  @override
  String get badge_aqua_legend_desc => '记录数据6个月';

  @override
  String get weekDayMon => '周一';

  @override
  String get weekDayTue => '周二';

  @override
  String get weekDayWed => '周三';

  @override
  String get weekDayThu => '周四';

  @override
  String get weekDayFri => '周五';

  @override
  String get weekDaySat => '周六';

  @override
  String get weekDaySun => '周日';

  @override
  String get add_reminder => '添加提醒';

  @override
  String get swipe_to_select_time => '滑动选择时间';

  @override
  String get hour => '小时';

  @override
  String get minute => '分钟';

  @override
  String get cancel => '取消';

  @override
  String get add => '添加';
}
