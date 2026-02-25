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

  @override
  String get badge_first_drop_name => '첫 물방울';

  @override
  String get badge_first_drop_desc => '처음으로 앱을 사용했습니다';

  @override
  String get badge_blue_spark_name => '블루 스파크';

  @override
  String get badge_blue_spark_desc => '처음으로 일일 목표를 달성했습니다';

  @override
  String get badge_flow_starter_name => '플로우 스타터';

  @override
  String get badge_flow_starter_desc => '5일 연속 목표 달성';

  @override
  String get badge_blue_energy_name => '블루 에너지';

  @override
  String get badge_blue_energy_desc => '일주일 동안 꾸준히 물을 마셨습니다';

  @override
  String get badge_water_hunter_name => '워터 헌터';

  @override
  String get badge_water_hunter_desc => '15일 동안 데이터를 기록했습니다';

  @override
  String get badge_hydro_master_name => '하이드로 마스터';

  @override
  String get badge_hydro_master_desc => '1개월 동안 데이터를 기록했습니다';

  @override
  String get badge_ocean_bender_name => '오션 킹';

  @override
  String get badge_ocean_bender_desc => '3개월 동안 데이터를 기록했습니다';

  @override
  String get badge_aqua_legend_name => '아쿠아 레전드';

  @override
  String get badge_aqua_legend_desc => '6개월 동안 데이터를 기록했습니다';

  @override
  String get weekDayMon => '월';

  @override
  String get weekDayTue => '화';

  @override
  String get weekDayWed => '수';

  @override
  String get weekDayThu => '목';

  @override
  String get weekDayFri => '금';

  @override
  String get weekDaySat => '토';

  @override
  String get weekDaySun => '일';

  @override
  String get add_reminder => '알림 추가';

  @override
  String get swipe_to_select_time => '스와이프하여 시간 선택';

  @override
  String get hour => '시간';

  @override
  String get minute => '분';

  @override
  String get cancel => '취소';

  @override
  String get add => '추가';
}
