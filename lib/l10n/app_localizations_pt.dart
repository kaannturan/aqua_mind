// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'Meta diária: $ml ml';
  }

  @override
  String get addWater => 'Adicionar água';

  @override
  String get weeklyTracking => 'Acompanhamento semanal';

  @override
  String get home => 'Início';

  @override
  String get reminder => 'Lembrete';

  @override
  String get settings => 'Configurações';

  @override
  String get languageSettings => 'Idioma';

  @override
  String get about => 'Sobre';

  @override
  String get feedback => 'Feedback';

  @override
  String get resetApp => 'Redefinir aplicativo';

  @override
  String get drinkRecommendation => 'Recomenda-se beber em média 2500 ml de água por dia.';

  @override
  String get dailyTarget => 'Sua meta diária : ';

  @override
  String get todayProgress => 'Seu progresso de hoje';

  @override
  String get feedbackTitle => 'O seu feedback é importante para nós.';

  @override
  String get feedbackContent => 'Muhammet Kaan Turan\n\nVocê pode enviar suas opiniões, sugestões e reclamações sobre o aplicativo para este endereço de e-mail. Todo feedback é muito importante para nós.\nkaannturan@gmail.com';

  @override
  String get drunkWater => 'Água consumida:';

  @override
  String get dailyGoalLabel => 'Meta diária:';

  @override
  String get remaining => 'Restante:';

  @override
  String completedPercent(Object percent) {
    return '%$percent concluído';
  }

  @override
  String get weeklyWaterTracking => 'Acompanhamento semanal de água';

  @override
  String get enableReminders => 'Ativar lembretes';

  @override
  String get dailyReminderDescription => 'Receba lembretes diários para beber água';

  @override
  String get reminderTimes => 'Horários dos lembretes';

  @override
  String get noReminderAdded => 'Você ainda não adicionou lembretes';

  @override
  String get addReminderHint => 'Toque no botão + acima\npara adicionar um novo lembrete';

  @override
  String get repeatsDaily => 'Repete diariamente';

  @override
  String get languageSelection => 'Seleção de idioma';

  @override
  String get infoTitle => 'Informação';

  @override
  String get reminderInfoDescription => 'Os lembretes enviarão notificações todos os dias nos horários definidos. A ingestão regular de água é muito importante para sua saúde! 💧';

  @override
  String get newBadgeTitle => '🎉 Novo emblema!';

  @override
  String get goButton => 'Ir';

  @override
  String get badge_first_drop_name => 'Primeira Gota';

  @override
  String get badge_first_drop_desc => 'Você usou o app pela primeira vez';

  @override
  String get badge_blue_spark_name => 'Faísca Azul';

  @override
  String get badge_blue_spark_desc => 'Você completou sua meta diária pela primeira vez';

  @override
  String get badge_flow_starter_name => 'Início do Fluxo';

  @override
  String get badge_flow_starter_desc => 'Meta concluída por 5 dias seguidos';

  @override
  String get badge_blue_energy_name => 'Energia Azul';

  @override
  String get badge_blue_energy_desc => 'Você bebeu água regularmente por uma semana';

  @override
  String get badge_water_hunter_name => 'Caçador de Água';

  @override
  String get badge_water_hunter_desc => 'Registrou dados por 15 dias';

  @override
  String get badge_hydro_master_name => 'Mestre Hydro';

  @override
  String get badge_hydro_master_desc => 'Registrou dados por 1 mês';

  @override
  String get badge_ocean_bender_name => 'Rei dos Oceanos';

  @override
  String get badge_ocean_bender_desc => 'Registrou dados por 3 meses';

  @override
  String get badge_aqua_legend_name => 'Lenda Aqua';

  @override
  String get badge_aqua_legend_desc => 'Registrou dados por 6 meses';

  @override
  String get weekDayMon => 'Seg';

  @override
  String get weekDayTue => 'Ter';

  @override
  String get weekDayWed => 'Qua';

  @override
  String get weekDayThu => 'Qui';

  @override
  String get weekDayFri => 'Sex';

  @override
  String get weekDaySat => 'Sáb';

  @override
  String get weekDaySun => 'Dom';
}
