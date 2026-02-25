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

  @override
  String get badge_first_drop_name => 'İlk Damla';

  @override
  String get badge_first_drop_desc => 'Uygulamayı ilk kez kullandın';

  @override
  String get badge_blue_spark_name => 'Mavi Kıvılcım';

  @override
  String get badge_blue_spark_desc => 'Günlük hedefini ilk kez tamamladın';

  @override
  String get badge_flow_starter_name => 'Akış Başlatıcı';

  @override
  String get badge_flow_starter_desc => '5 gün üst üste hedefini tamamladın';

  @override
  String get badge_blue_energy_name => 'Mavi Enerji';

  @override
  String get badge_blue_energy_desc => 'İlk hafta düzenli su içtin';

  @override
  String get badge_water_hunter_name => 'Su Avcısı';

  @override
  String get badge_water_hunter_desc => '15 gün veri girdin';

  @override
  String get badge_hydro_master_name => 'Hydro Ustası';

  @override
  String get badge_hydro_master_desc => '1 ay boyunca veri girdin';

  @override
  String get badge_ocean_bender_name => 'Okyanuslar Kralı';

  @override
  String get badge_ocean_bender_desc => '3 ay boyunca veri girdin';

  @override
  String get badge_aqua_legend_name => 'Aqua Efsanesi';

  @override
  String get badge_aqua_legend_desc => '6 ay boyunca veri girdin';

  @override
  String get weekDayMon => 'Pzt';

  @override
  String get weekDayTue => 'Sal';

  @override
  String get weekDayWed => 'Çar';

  @override
  String get weekDayThu => 'Per';

  @override
  String get weekDayFri => 'Cum';

  @override
  String get weekDaySat => 'Cmt';

  @override
  String get weekDaySun => 'Paz';

  @override
  String get add_reminder => 'Hatırlatıcı Ekle';

  @override
  String get swipe_to_select_time => 'Kaydırarak saat seçin';

  @override
  String get hour => 'SAAT';

  @override
  String get minute => 'DAKİKA';

  @override
  String get cancel => 'İptal';

  @override
  String get add => 'Ekle';
}
