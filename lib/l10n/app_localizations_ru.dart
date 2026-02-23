// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'Дневная цель: $ml мл';
  }

  @override
  String get addWater => 'Добавить воду';

  @override
  String get weeklyTracking => 'Недельный отчет';

  @override
  String get home => 'Главная';

  @override
  String get reminder => 'Напоминание';

  @override
  String get settings => 'Настройки';

  @override
  String get languageSettings => 'Язык';

  @override
  String get about => 'О нас';

  @override
  String get feedback => 'Отзыв';

  @override
  String get resetApp => 'Сбросить приложение';

  @override
  String get drinkRecommendation => 'Рекомендуется пить в среднем 2500 мл воды в день.';

  @override
  String get dailyTarget => 'Ваша дневная цель : ';

  @override
  String get todayProgress => 'Твой прогресс за сегодня';

  @override
  String get feedbackTitle => 'Ваше мнение важно для нас.';

  @override
  String get feedbackContent => 'Muhammet Kaan Turan\n\nВы можете отправить свои отзывы, предложения и жалобы по поводу приложения на этот адрес электронной почты. Любая обратная связь очень важна для нас.\nkaannturan@gmail.com';

  @override
  String get drunkWater => 'Выпито воды:';

  @override
  String get dailyGoalLabel => 'Дневная цель:';

  @override
  String get remaining => 'Осталось:';

  @override
  String completedPercent(Object percent) {
    return '%$percent завершено';
  }

  @override
  String get weeklyWaterTracking => 'Еженедельный учет воды';

  @override
  String get enableReminders => 'Включить напоминания';

  @override
  String get dailyReminderDescription => 'Получать ежедневные напоминания о воде';

  @override
  String get reminderTimes => 'Время напоминаний';

  @override
  String get noReminderAdded => 'Вы еще не добавили напоминания';

  @override
  String get addReminderHint => 'Нажмите кнопку + выше,\nчтобы добавить новое напоминание';

  @override
  String get repeatsDaily => 'Повторяется ежедневно';

  @override
  String get languageSelection => 'Выбор языка';

  @override
  String get infoTitle => 'Информация';

  @override
  String get reminderInfoDescription => 'Напоминания будут отправлять вам уведомления каждый день в установленное время. Регулярное потребление воды очень важно для вашего здоровья! 💧';

  @override
  String get newBadgeTitle => '🎉 Новый значок!';

  @override
  String get goButton => 'Перейти';

  @override
  String get badge_first_drop_name => 'Первая Капля';

  @override
  String get badge_first_drop_desc => 'Вы впервые использовали приложение';

  @override
  String get badge_blue_spark_name => 'Синяя Искра';

  @override
  String get badge_blue_spark_desc => 'Вы впервые достигли дневной цели';

  @override
  String get badge_flow_starter_name => 'Начало Потока';

  @override
  String get badge_flow_starter_desc => 'Цель выполнена 5 дней подряд';

  @override
  String get badge_blue_energy_name => 'Синяя Энергия';

  @override
  String get badge_blue_energy_desc => 'Вы регулярно пили воду в течение недели';

  @override
  String get badge_water_hunter_name => 'Охотник за Водой';

  @override
  String get badge_water_hunter_desc => 'Вводили данные 15 дней';

  @override
  String get badge_hydro_master_name => 'Гидро-Мастер';

  @override
  String get badge_hydro_master_desc => 'Вводили данные 1 месяц';

  @override
  String get badge_ocean_bender_name => 'Король Океанов';

  @override
  String get badge_ocean_bender_desc => 'Вводили данные 3 месяца';

  @override
  String get badge_aqua_legend_name => 'Легенда Aqua';

  @override
  String get badge_aqua_legend_desc => 'Вводили данные 6 месяцев';

  @override
  String get weekDayMon => 'Пн';

  @override
  String get weekDayTue => 'Вт';

  @override
  String get weekDayWed => 'Ср';

  @override
  String get weekDayThu => 'Чт';

  @override
  String get weekDayFri => 'Пт';

  @override
  String get weekDaySat => 'Сб';

  @override
  String get weekDaySun => 'Вс';
}
