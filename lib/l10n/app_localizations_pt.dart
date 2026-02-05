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
}
