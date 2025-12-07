// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Rozet Modeli
class Badgee {
  final String id;
  final String name;
  final String description;
  final String icon;
  final bool isUnlocked;

  Badgee({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
    this.isUnlocked = false,
  });

  Badgee copyWith({bool? isUnlocked}) {
    return Badgee(
      id: this.id,
      name: this.name,
      description: this.description,
      icon: this.icon,
      isUnlocked: isUnlocked ?? this.isUnlocked,
    );
  }
}

// Seviye Sistemi
class LevelSystem {
  static Future<int> getCurrentLevel() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userLevel') ?? 1;
  }

  static Future<void> setLevel(int level) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('userLevel', level);
  }

  static Future<int> getConsecutiveDays() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('consecutiveDays') ?? 0;
  }

  static Future<void> updateConsecutiveDays() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final lastDate = prefs.getString('lastConsecutiveDate');

    if (lastDate == null) {
      // İlk gün
      await prefs.setInt('consecutiveDays', 1);
      await prefs.setString('lastConsecutiveDate', _formatDate(today));
      return;
    }

    final lastDateTime = DateTime.parse(lastDate);
    final difference = today.difference(lastDateTime).inDays;

    if (difference == 1) {
      // Ardışık gün
      final current = await getConsecutiveDays();
      await prefs.setInt('consecutiveDays', current + 1);
      await prefs.setString('lastConsecutiveDate', _formatDate(today));

      // Her 7 günde bir seviye atla
      if ((current + 1) % 7 == 0) {
        final level = await getCurrentLevel();
        await setLevel(level + 1);
      }
    } else if (difference > 1) {
      // Seri kırıldı
      await prefs.setInt('consecutiveDays', 1);
      await prefs.setString('lastConsecutiveDate', _formatDate(today));
    }
    // difference == 0 ise bugün zaten kaydedilmiş
  }

  static String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";
  }

  static Future<int> getTotalDaysWithData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> allDates = prefs.getStringList('allDataDates') ?? [];
    return allDates.length;
  }

  static Future<void> addDataDate(String date) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> allDates = prefs.getStringList('allDataDates') ?? [];

    if (!allDates.contains(date)) {
      allDates.add(date);
      await prefs.setStringList('allDataDates', allDates);
    }
  }
}

// Rozet Sistemi
class BadgeSystem {
  static List<Badgee> getAllBadges() {
    return [
      Badgee(
        id: 'first_drop',
        name: 'İlk Damla',
        description: 'Uygulamayı ilk kez kullandın',
        icon: '💧',
      ),
      Badgee(
        id: 'blue_spark',
        name: 'Mavi Kıvılcım',
        description: 'Günlük hedefini ilk kez tamamladın',
        icon: '⚡',
      ),
      Badgee(
        id: 'healer',
        name: 'Şifacı',
        description: 'Uygulamayı bir arkadaşına paylaştın',
        icon: '🌟',
      ),
      Badgee(
        id: 'flow_starter',
        name: 'Akış Başlatıcı',
        description: '5 gün üst üste hedefini tamamladın',
        icon: '🌊',
      ),
      Badgee(
        id: 'blue_energy',
        name: 'Mavi Enerji',
        description: 'İlk hafta düzenli su içtin',
        icon: '💙',
      ),
      Badgee(
        id: 'water_hunter',
        name: 'Su Avcısı',
        description: '15 gün veri girdin',
        icon: '🎯',
      ),
      Badgee(
        id: 'hydro_master',
        name: 'Hydro Ustası',
        description: '1 ay boyunca veri girdin',
        icon: '🌀',
      ),
      Badgee(
        id: 'ocean_bender',
        name: 'Okyanuslar Kralı',
        description: '3 ay boyunca veri girdin',
        icon: '👑',
      ),
      Badgee(
        id: 'aqua_legend',
        name: 'Aqua Efsanesi',
        description: '6 ay boyunca veri girdin',
        icon: '🏆',
      ),
    ];
  }

  static Future<List<Badgee>> getUnlockedBadges() async {
    final prefs = await SharedPreferences.getInstance();
    final unlockedIds = prefs.getStringList('unlockedBadges') ?? [];

    return getAllBadges().map((badge) {
      return badge.copyWith(isUnlocked: unlockedIds.contains(badge.id));
    }).toList();
  }

  static Future<void> unlockBadge(String badgeId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> unlockedIds = prefs.getStringList('unlockedBadges') ?? [];

    if (!unlockedIds.contains(badgeId)) {
      unlockedIds.add(badgeId);
      await prefs.setStringList('unlockedBadges', unlockedIds);
    }
  }

  static Future<void> checkAndUnlockBadges(
      int currentWater, int targetWater) async {
    final consecutiveDays = await LevelSystem.getConsecutiveDays();
    final totalDays = await LevelSystem.getTotalDaysWithData();

    // İlk Damla - ilk veri
    if (totalDays >= 1) {
      await unlockBadge('first_drop');
    }

    // Mavi Kıvılcım - ilk hedef tamamlama
    if (currentWater >= targetWater) {
      await unlockBadge('blue_spark');
    }

    // Akış Başlatıcı - 5 gün üst üste
    if (consecutiveDays >= 5) {
      await unlockBadge('flow_starter');
    }

    // Mavi Enerji - 7 gün veri
    if (totalDays >= 7) {
      await unlockBadge('blue_energy');
    }

    // Su Avcısı - 15 gün
    if (totalDays >= 15) {
      await unlockBadge('water_hunter');
    }

    // Hydro Ustası - 30 gün
    if (totalDays >= 30) {
      await unlockBadge('hydro_master');
    }

    // Okyanuslar Kralı - 90 gün
    if (totalDays >= 90) {
      await unlockBadge('ocean_bender');
    }

    // Aqua Efsanesi - 180 gün
    if (totalDays >= 180) {
      await unlockBadge('aqua_legend');
    }
  }

  // DIALOG FONKSİYONU
  static void showBadgesDialog(BuildContext context, List<Badgee> badges) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: MediaQuery.of(context).size.height * 0.7,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black, Color(0xff062549)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24, width: 2),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Rozetlerim',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: EdgeInsets.all(16),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 16,
                      mainAxisSpacing: 16,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: badges.length,
                    itemBuilder: (context, index) {
                      final badge = badges[index];
                      return Container(
                        decoration: BoxDecoration(
                          color: badge.isUnlocked
                              ? Colors.blue.withOpacity(0.2)
                              : Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: badge.isUnlocked
                                ? Colors.blue.shade300
                                : Colors.white24,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              badge.icon,
                              style: TextStyle(
                                fontSize: 40,
                                color: badge.isUnlocked
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.3),
                              ),
                            ),
                            SizedBox(height: 8),
                            Text(
                              badge.name,
                              style: TextStyle(
                                color: badge.isUnlocked
                                    ? Colors.white
                                    : Colors.white54,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            SizedBox(height: 4),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Text(
                                badge.description,
                                style: TextStyle(
                                  color: badge.isUnlocked
                                      ? Colors.white70
                                      : Colors.white38,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            if (!badge.isUnlocked)
                              Padding(
                                padding: EdgeInsets.only(top: 4),
                                child: Icon(
                                  FontAwesomeIcons.lock,
                                  color: Colors.white38,
                                  size: 12,
                                ),
                              ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
