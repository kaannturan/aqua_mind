// ignore_for_file: deprecated_member_use, unnecessary_this, use_build_context_synchronously

import 'package:aqua_mind/l10n/app_localizations.dart';
import 'package:aqua_mind/models/badgee_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    final todayString = formatDate(today);
    final lastDate = prefs.getString('lastConsecutiveDate');

    if (lastDate == null) {
      await prefs.setInt('consecutiveDays', 1);
      await prefs.setString('lastConsecutiveDate', todayString);
      return;
    }

    if (lastDate == todayString) {
      return;
    }

    final lastDateTime = DateTime.parse(lastDate);
    final todayDateTime = DateTime.parse(todayString);
    final difference = todayDateTime.difference(lastDateTime).inDays;

    if (difference == 1) {
      final current = await getConsecutiveDays();
      await prefs.setInt('consecutiveDays', current + 1);
      await prefs.setString('lastConsecutiveDate', todayString);

      if ((current + 1) % 7 == 0) {
        final level = await getCurrentLevel();
        await setLevel(level + 1);
      }
    } else if (difference > 1) {
      await prefs.setInt('consecutiveDays', 1);
      await prefs.setString('lastConsecutiveDate', todayString);
    }
  }

  static String formatDate(DateTime date) {
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
        iconData: FontAwesomeIcons.droplet,
      ),
      Badgee(
        id: 'blue_spark',
        name: 'Mavi Kıvılcım',
        description: 'Günlük hedefini ilk kez tamamladın',
        iconData: FontAwesomeIcons.boltLightning,
      ),
      Badgee(
        id: 'flow_starter',
        name: 'Akış Başlatıcı',
        description: '5 gün üst üste hedefini tamamladın',
        iconData: FontAwesomeIcons.fire,
      ),
      Badgee(
        id: 'blue_energy',
        name: 'Mavi Enerji',
        description: 'İlk hafta düzenli su içtin',
        iconData: FontAwesomeIcons.star,
      ),
      Badgee(
        id: 'water_hunter',
        name: 'Su Avcısı',
        description: '15 gün veri girdin',
        iconData: FontAwesomeIcons.bullseye,
      ),
      Badgee(
        id: 'hydro_master',
        name: 'Hydro Ustası',
        description: '1 ay boyunca veri girdin',
        iconData: FontAwesomeIcons.medal,
      ),
      Badgee(
        id: 'ocean_bender',
        name: 'Okyanuslar Kralı',
        description: '3 ay boyunca veri girdin',
        iconData: FontAwesomeIcons.crown,
      ),
      Badgee(
        id: 'aqua_legend',
        name: 'Aqua Efsanesi',
        description: '6 ay boyunca veri girdin',
        iconData: FontAwesomeIcons.trophy,
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

  static Future<bool> unlockBadge(String badgeId) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> unlockedIds = prefs.getStringList('unlockedBadges') ?? [];

    if (!unlockedIds.contains(badgeId)) {
      unlockedIds.add(badgeId);
      await prefs.setStringList('unlockedBadges', unlockedIds);
      return true;
    }
    return false;
  }

  static Future<List<String>> checkAndUnlockBadges(
      int currentWater, int targetWater) async {
    List<String> newBadges = [];

    final consecutiveDays = await LevelSystem.getConsecutiveDays();
    final totalDays = await LevelSystem.getTotalDaysWithData();

    if (totalDays >= 1) {
      bool isNew = await unlockBadge('first_drop');
      if (isNew) newBadges.add('first_drop');
    }

    if (currentWater >= targetWater) {
      bool isNew = await unlockBadge('blue_spark');
      if (isNew) newBadges.add('blue_spark');
    }

    if (consecutiveDays >= 5) {
      bool isNew = await unlockBadge('flow_starter');
      if (isNew) newBadges.add('flow_starter');
    }

    if (totalDays >= 7) {
      bool isNew = await unlockBadge('blue_energy');
      if (isNew) newBadges.add('blue_energy');
    }

    if (totalDays >= 15) {
      bool isNew = await unlockBadge('water_hunter');
      if (isNew) newBadges.add('water_hunter');
    }

    if (totalDays >= 30) {
      bool isNew = await unlockBadge('hydro_master');
      if (isNew) newBadges.add('hydro_master');
    }

    if (totalDays >= 90) {
      bool isNew = await unlockBadge('ocean_bender');
      if (isNew) newBadges.add('ocean_bender');
    }

    if (totalDays >= 180) {
      bool isNew = await unlockBadge('aqua_legend');
      if (isNew) newBadges.add('aqua_legend');
    }

    return newBadges;
  }

  // IconData
  static void showNewBadgeNotification(BuildContext context, String badgeId) {
    final badge = getAllBadges().firstWhere((b) => b.id == badgeId);
    final loc = AppLocalizations.of(context)!;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.blue.shade700,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Row(
          children: [
            // Icon widget kullanımı
            Icon(
              badge.iconData,
              color: Colors.white,
              size: 24,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    loc.newBadgeTitle,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Text(badge.name, style: TextStyle(fontSize: 14)),
                ],
              ),
            ),
          ],
        ),
        duration: Duration(seconds: 5),
        action: SnackBarAction(
          label: loc.goButton,
          textColor: Colors.white,
          onPressed: () async {
            final badges = await getUnlockedBadges();
            showBadgesDialog(context, badges);
          },
        ),
      ),
    );
  }

  // Dialog'da icon gösterimi
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
                            // Icon widget kullanımı
                            Icon(
                              badge.iconData,
                              size: 40,
                              color: badge.isUnlocked
                                  ? Colors.blue.shade300
                                  : Colors.white.withOpacity(0.3),
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
