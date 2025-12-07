// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'Mục tiêu nước hằng ngày: $ml ml';
  }

  @override
  String get addWater => 'Thêm nước';

  @override
  String get weeklyTracking => 'Theo dõi hàng tuần';
}
