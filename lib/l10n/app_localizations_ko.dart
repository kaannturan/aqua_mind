// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Korean (`ko`).
class AppLocalizationsKo extends AppLocalizations {
  AppLocalizationsKo([String locale = 'ko']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return '일일 목표: $ml ml';
  }

  @override
  String get addWater => '물 추가';

  @override
  String get weeklyTracking => '주간 추적';

  @override
  String get home => '홈';

  @override
  String get reminder => '알림';

  @override
  String get settings => '설정';

  @override
  String get languageSettings => '언어';

  @override
  String get about => '정보';

  @override
  String get feedback => '피드백';

  @override
  String get resetApp => '앱 재설정';

  @override
  String get drinkRecommendation => '하루 평균 2500ml의 물을 마시는 것이 권장됩니다';

  @override
  String get dailyTarget => '하루 목표 : ';

  @override
  String get todayProgress => '오늘의 진행 상황';
}
