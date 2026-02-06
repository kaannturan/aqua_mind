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
}
