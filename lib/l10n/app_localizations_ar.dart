// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'الهدف اليومي: $ml مل';
  }

  @override
  String get addWater => 'إضافة ماء';

  @override
  String get weeklyTracking => 'متابعة أسبوعية';

  @override
  String get home => 'الرئيسية';

  @override
  String get reminder => 'تذكير';

  @override
  String get settings => 'الإعدادات';

  @override
  String get languageSettings => 'اللغة';

  @override
  String get about => 'حول';

  @override
  String get feedback => 'ملاحظات';

  @override
  String get resetApp => 'إعادة ضبط التطبيق';

  @override
  String get drinkRecommendation => 'يُنصح بشرب متوسط 2500 مل من الماء يوميًا :)';

  @override
  String get dailyTarget => 'هدفك اليومي:';

  @override
  String get todayProgress => 'تقدمك اليوم:';

  @override
  String get feedbackTitle => 'ملاحظاتكم مهمة بالنسبة لنا.';

  @override
  String get feedbackContent => 'Muhammet Kaan Turan\n\nيمكنكم إرسال آرائكم واقتراحاتكم وشكاواكم المتعلقة بالتطبيق إلى عنوان البريد الإلكتروني هذا. جميع الملاحظات ذات أهمية كبيرة بالنسبة لنا.\nkaannturan@gmail.com';

  @override
  String get drunkWater => 'Water Consumed:';

  @override
  String get dailyGoalLabel => 'Daily Goal:';

  @override
  String get remaining => 'Remaining:';

  @override
  String completedPercent(Object percent) {
    return '%$percent completed';
  }

  @override
  String get weeklyWaterTracking => 'Weekly Water Tracking';

  @override
  String get enableReminders => 'تفعيل التذكيرات';

  @override
  String get dailyReminderDescription => 'استلام تذكيرات يومية لشرب الماء';

  @override
  String get reminderTimes => 'أوقات التذكير';

  @override
  String get noReminderAdded => 'لم تقم بإضافة أي تذكير بعد';

  @override
  String get addReminderHint => 'اضغط على زر + أعلاه\nلإضافة تذكير جديد';

  @override
  String get repeatsDaily => 'يتكرر يومياً';

  @override
  String get languageSelection => 'Language Selection';

  @override
  String get infoTitle => 'معلومة';

  @override
  String get reminderInfoDescription => 'سترسل التذكيرات إشعارات يوميًا في الأوقات التي حددتها. شرب الماء بانتظام مهم جدًا لصحتك! 💧';
}
