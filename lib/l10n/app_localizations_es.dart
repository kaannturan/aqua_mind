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

  @override
  String get badge_first_drop_name => 'Primera Gota';

  @override
  String get badge_first_drop_desc => 'Usaste la app por primera vez';

  @override
  String get badge_blue_spark_name => 'Chispa Azul';

  @override
  String get badge_blue_spark_desc => 'Completaste tu meta diaria por primera vez';

  @override
  String get badge_flow_starter_name => 'Iniciador de Flujo';

  @override
  String get badge_flow_starter_desc => 'Meta completada 5 días seguidos';

  @override
  String get badge_blue_energy_name => 'Energía Azul';

  @override
  String get badge_blue_energy_desc => 'Bebiste agua regularmente durante una semana';

  @override
  String get badge_water_hunter_name => 'Cazador de Agua';

  @override
  String get badge_water_hunter_desc => 'Registraste datos durante 15 días';

  @override
  String get badge_hydro_master_name => 'Maestro Hydro';

  @override
  String get badge_hydro_master_desc => 'Registraste datos durante 1 mes';

  @override
  String get badge_ocean_bender_name => 'Rey del Océano';

  @override
  String get badge_ocean_bender_desc => 'Registraste datos durante 3 meses';

  @override
  String get badge_aqua_legend_name => 'Leyenda Aqua';

  @override
  String get badge_aqua_legend_desc => 'Registraste datos durante 6 meses';

  @override
  String get weekDayMon => 'Lun';

  @override
  String get weekDayTue => 'Mar';

  @override
  String get weekDayWed => 'Mié';

  @override
  String get weekDayThu => 'Jue';

  @override
  String get weekDayFri => 'Vie';

  @override
  String get weekDaySat => 'Sáb';

  @override
  String get weekDaySun => 'Dom';

  @override
  String get add_reminder => 'Agregar recordatorio';

  @override
  String get swipe_to_select_time => 'Desliza para seleccionar la hora';

  @override
  String get hour => 'HORA';

  @override
  String get minute => 'MINUTO';

  @override
  String get cancel => 'Cancelar';

  @override
  String get add => 'Agregar';
}
