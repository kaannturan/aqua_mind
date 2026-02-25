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
  String get drinkRecommendation => 'يُنصح بشرب متوسط 2500 مل من الماء يوميًا 🙂';

  @override
  String get dailyTarget => 'هدفك اليومي :';

  @override
  String get todayProgress => 'تقدمك اليوم :';

  @override
  String get feedbackTitle => 'ملاحظاتكم مهمة بالنسبة لنا.';

  @override
  String get feedbackContent => 'Muhammet Kaan Turan\n\nيمكنكم إرسال آرائكم واقتراحاتكم وشكاواكم المتعلقة بالتطبيق إلى عنوان البريد الإلكتروني هذا. جميع الملاحظات ذات أهمية كبيرة بالنسبة لنا.\nkaannturan@gmail.com';

  @override
  String get drunkWater => 'الماء المُشرب :';

  @override
  String get dailyGoalLabel => 'الهدف اليومي :';

  @override
  String get remaining => 'المتبقي :';

  @override
  String completedPercent(Object percent) {
    return '%$percent مكتمل';
  }

  @override
  String get weeklyWaterTracking => 'متابعة الماء الأسبوعية';

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
  String get repeatsDaily => 'يتكرر يوميًا';

  @override
  String get languageSelection => 'اختيار اللغة';

  @override
  String get infoTitle => 'معلومة';

  @override
  String get reminderInfoDescription => 'سترسل التذكيرات إشعارات يوميًا في الأوقات التي حددتها. شرب الماء بانتظام مهم جدًا لصحتك! 💧';

  @override
  String get newBadgeTitle => '🎉 شارة جديدة!';

  @override
  String get goButton => 'اذهب';

  @override
  String get badge_first_drop_name => 'القطرة الأولى';

  @override
  String get badge_first_drop_desc => 'لقد استخدمت التطبيق لأول مرة';

  @override
  String get badge_blue_spark_name => 'الشرارة الزرقاء';

  @override
  String get badge_blue_spark_desc => 'أكملت هدفك اليومي لأول مرة';

  @override
  String get badge_flow_starter_name => 'بداية التدفق';

  @override
  String get badge_flow_starter_desc => 'أكملت الهدف لمدة 5 أيام متتالية';

  @override
  String get badge_blue_energy_name => 'الطاقة الزرقاء';

  @override
  String get badge_blue_energy_desc => 'شربت الماء بانتظام لمدة أسبوع';

  @override
  String get badge_water_hunter_name => 'صياد الماء';

  @override
  String get badge_water_hunter_desc => 'أدخلت البيانات لمدة 15 يومًا';

  @override
  String get badge_hydro_master_name => 'سيد الهيدرو';

  @override
  String get badge_hydro_master_desc => 'أدخلت البيانات لمدة شهر واحد';

  @override
  String get badge_ocean_bender_name => 'ملك المحيطات';

  @override
  String get badge_ocean_bender_desc => 'أدخلت البيانات لمدة 3 أشهر';

  @override
  String get badge_aqua_legend_name => 'أسطورة أكوا';

  @override
  String get badge_aqua_legend_desc => 'أدخلت البيانات لمدة 6 أشهر';

  @override
  String get weekDayMon => 'الإثنين';

  @override
  String get weekDayTue => 'الثلاثاء';

  @override
  String get weekDayWed => 'الأربعاء';

  @override
  String get weekDayThu => 'الخميس';

  @override
  String get weekDayFri => 'الجمعة';

  @override
  String get weekDaySat => 'السبت';

  @override
  String get weekDaySun => 'الأحد';

  @override
  String get add_reminder => 'إضافة تذكير';

  @override
  String get swipe_to_select_time => 'اسحب لاختيار الوقت';

  @override
  String get hour => 'ساعة';

  @override
  String get minute => 'دقيقة';

  @override
  String get cancel => 'إلغاء';

  @override
  String get add => 'إضافة';
}
