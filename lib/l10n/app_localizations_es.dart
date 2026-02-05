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
}
