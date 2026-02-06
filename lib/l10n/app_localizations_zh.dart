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
}
