// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get appTitle => 'AquaMind';

  @override
  String home_dailyGoal(Object ml) {
    return 'Günlük hedef: $ml ml';
  }

  @override
  String get addWater => 'Su ekle';

  @override
  String get weeklyTracking => 'Haftalık takip';

  @override
  String get home => 'Ana Sayfa';

  @override
  String get reminder => 'Hatırlatıcı';

  @override
  String get settings => 'Ayarlar';

  @override
  String get languageSettings => 'Dil Ayarları';

  @override
  String get about => 'Hakkımızda';

  @override
  String get feedback => 'Görüşleriniz';

  @override
  String get resetApp => 'Uygulamayı Sıfırla';

  @override
  String get drinkRecommendation => 'Günde ortalama 2500 ml su içmeniz önerilir.';

  @override
  String get dailyTarget => 'Günlük hedefiniz : ';

  @override
  String get todayProgress => 'Bugünkü ilerlemen';

  @override
  String get feedbackTitle => 'Görüşleriniz bizim için değerli.';

  @override
  String get feedbackContent => 'Muhammet Kaan Turan\n\nUygulama ile ilgili görüş, öneri ve şikayetlerinizi bu mail adresine iletebilirsiniz. Tüm geri bildirimler bizim için çok değerli.\nkaannturan@gmail.com';

  @override
  String get drunkWater => 'İçilen Su:';

  @override
  String get dailyGoalLabel => 'Günlük Hedef:';

  @override
  String get remaining => 'Kalan:';

  @override
  String completedPercent(Object percent) {
    return '%$percent tamamlandı';
  }

  @override
  String get weeklyWaterTracking => 'Haftalık Su Takibi';

  @override
  String get enableReminders => 'Hatırlatıcıları Aktif Et';

  @override
  String get dailyReminderDescription => 'Günlük su içme hatırlatıcıları al';

  @override
  String get reminderTimes => 'Hatırlatıcı Zamanları';

  @override
  String get noReminderAdded => 'Henüz hatırlatıcı eklemediniz';

  @override
  String get addReminderHint => 'Yukarıdaki + butonuna tıklayarak\nyeni hatırlatıcı ekleyin';

  @override
  String get repeatsDaily => 'Her gün tekrarlanacak';

  @override
  String get languageSelection => 'Dil Seçimi';

  @override
  String get infoTitle => 'Bilgi';

  @override
  String get reminderInfoDescription => 'Hatırlatıcılar her gün belirlediğiniz saatlerde size bildirim gönderecektir. Düzenli su tüketimi sağlığınız için çok önemlidir! 💧';

  @override
  String get newBadgeTitle => '🎉 Yeni Rozet!';

  @override
  String get goButton => 'Git';
}
