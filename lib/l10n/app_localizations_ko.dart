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

  @override
  String get feedbackTitle => '여러분의 의견은 저희에게 소중합니다.';

  @override
  String get feedbackContent => 'Muhammet Kaan Turan\n\n앱에 대한 의견, 제안 및 불만 사항을 이 이메일 주소로 보내주세요. 모든 피드백은 저희에게 매우 중요합니다.\nkaannturan@gmail.com';

  @override
  String get drunkWater => '섭취한 물:';

  @override
  String get dailyGoalLabel => '일일 목표:';

  @override
  String get remaining => '남은 양:';

  @override
  String completedPercent(Object percent) {
    return '%$percent% 완료';
  }

  @override
  String get weeklyWaterTracking => '주간 물 섭취 추적';

  @override
  String get enableReminders => '알림 활성화';

  @override
  String get dailyReminderDescription => '매일 물 마시기 알림 받기';

  @override
  String get reminderTimes => '알림 시간';

  @override
  String get noReminderAdded => '아직 알림을 추가하지 않았습니다';

  @override
  String get addReminderHint => '위의 + 버튼을 눌러\n새 알림을 추가하세요';

  @override
  String get repeatsDaily => '매일 반복';

  @override
  String get languageSelection => '언어 선택';

  @override
  String get infoTitle => '정보';

  @override
  String get reminderInfoDescription => '알림은 설정한 시간에 매일 알림을 보냅니다. 규칙적인 수분 섭취는 건강에 매우 중요합니다! 💧';

  @override
  String get newBadgeTitle => '🎉 새로운 배지!';

  @override
  String get goButton => '이동';
}
