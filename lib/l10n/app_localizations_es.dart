// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'Meta diaria: $ml ml';
  }

  @override
  String get addWater => 'Añadir agua';

  @override
  String get weeklyTracking => 'Seguimiento semanal';

  @override
  String get home => 'Inicio';

  @override
  String get reminder => 'Recordatorio';

  @override
  String get settings => 'Ajustes';

  @override
  String get languageSettings => 'Idioma';

  @override
  String get about => 'Acerca de';

  @override
  String get feedback => 'Opinión';

  @override
  String get resetApp => 'Restablecer aplicación';

  @override
  String get drinkRecommendation => 'Se recomienda beber un promedio de 2500 ml de agua al día.';

  @override
  String get dailyTarget => 'Tu objetivo diario : ';

  @override
  String get todayProgress => 'Tu progreso de hoy';

  @override
  String get feedbackTitle => 'Su opinión es valiosa para nosotros.';

  @override
  String get feedbackContent => 'Muhammet Kaan Turan\n\nPuede enviar sus opiniones, sugerencias y quejas sobre la aplicación a esta dirección de correo electrónico. Todos los comentarios son muy importantes para nosotros.\nkaannturan@gmail.com';

  @override
  String get drunkWater => 'Agua consumida:';

  @override
  String get dailyGoalLabel => 'Meta diaria:';

  @override
  String get remaining => 'Restante:';

  @override
  String completedPercent(Object percent) {
    return '%$percent completado';
  }

  @override
  String get weeklyWaterTracking => 'Seguimiento semanal de agua';

  @override
  String get enableReminders => 'Activar recordatorios';

  @override
  String get dailyReminderDescription => 'Recibe recordatorios diarios para beber agua';

  @override
  String get reminderTimes => 'Horarios de recordatorio';

  @override
  String get noReminderAdded => 'Aún no has añadido recordatorios';

  @override
  String get addReminderHint => 'Pulsa el botón + de arriba\npara añadir un nuevo recordatorio';

  @override
  String get repeatsDaily => 'Se repite diariamente';

  @override
  String get languageSelection => 'Selección de idioma';

  @override
  String get infoTitle => 'Información';

  @override
  String get reminderInfoDescription => 'Los recordatorios te enviarán notificaciones todos los días a las horas que hayas establecido. Beber agua regularmente es muy importante para tu salud. 💧';

  @override
  String get newBadgeTitle => '🎉 ¡Nueva insignia!';

  @override
  String get goButton => 'Ir';
}
