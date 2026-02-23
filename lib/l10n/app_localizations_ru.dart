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
}
