// ignore_for_file: deprecated_member_use, unnecessary_this, use_build_context_synchronously

import 'dart:ui';
import 'package:aqua_mind/l10n/app_localizations.dart';
import 'package:aqua_mind/models/badgee_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ─────────────────────────────────────────────────────────────────────────────
// Badge Unlock Overlay Widget
// ─────────────────────────────────────────────────────────────────────────────

class _BadgeUnlockOverlay extends StatefulWidget {
  final Badgee badge;
  final String newBadgeTitle;
  final VoidCallback onDismiss;
  final VoidCallback onViewAll;

  const _BadgeUnlockOverlay({
    required this.badge,
    required this.newBadgeTitle,
    required this.onDismiss,
    required this.onViewAll,
  });

  @override
  State<_BadgeUnlockOverlay> createState() => _BadgeUnlockOverlayState();
}

class _BadgeUnlockOverlayState extends State<_BadgeUnlockOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnim;
  late Animation<double> _fadeAnim;
  late Animation<double> _scaleAnim;
  late Animation<double> _shimmerAnim;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 2.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutBack,
    ));

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    _scaleAnim = Tween<double>(begin: 0.88, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutBack),
    );

    _shimmerAnim = Tween<double>(begin: -1.0, end: 2.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.4, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();

    Future.delayed(const Duration(milliseconds: 8000), () {
      if (mounted) _dismiss();
    });
  }

  Future<void> _dismiss() async {
    if (!mounted) return;
    await _controller.reverse(from: 1.0);
    widget.onDismiss();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnim,
          child: FadeTransition(
            opacity: _fadeAnim,
            child: ScaleTransition(
              scale: _scaleAnim,
              child: GestureDetector(
                onTap: _dismiss,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF0A1F38), Color(0xFF062549)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border.all(
                      color: Colors.blue.shade300.withOpacity(0.15),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.blue.shade900.withOpacity(0.30),
                        blurRadius: 28,
                        spreadRadius: 2,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(22),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                      child: Stack(
                        children: [
                          // Shimmer şeridi
                          Positioned.fill(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(22),
                              child: ShaderMask(
                                shaderCallback: (bounds) {
                                  return LinearGradient(
                                    begin: Alignment(
                                        _shimmerAnim.value - 0.4, -0.5),
                                    end: Alignment(_shimmerAnim.value + 0.4, 1),
                                    colors: [
                                      Colors.transparent,
                                      Colors.white.withOpacity(0.06),
                                      Colors.transparent,
                                    ],
                                  ).createShader(bounds);
                                },
                                child: Container(color: Colors.white),
                              ),
                            ),
                          ),

                          // İçerik
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 18, vertical: 16),
                            child: Row(
                              children: [
                                // Sol: Rozet ikon kutusu
                                Container(
                                  width: 58,
                                  height: 58,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.amber.shade400,
                                        Colors.orange.shade600,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.amber.withOpacity(0.10),
                                        blurRadius: 16,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: Icon(
                                    widget.badge.iconData,
                                    color: Colors.white,
                                    size: 26,
                                  ),
                                ),

                                const SizedBox(width: 14),

                                // Orta: Metin
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Üst satır: rozet kazanıldı etiketi
                                      Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8, vertical: 3),
                                            decoration: BoxDecoration(
                                              gradient: LinearGradient(
                                                colors: [
                                                  Colors.amber.shade600,
                                                  Colors.orange.shade500,
                                                ],
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(
                                                  FontAwesomeIcons.vaadin,
                                                  color: Colors.white,
                                                  size: 10,
                                                ),
                                                const SizedBox(width: 5),
                                                Text(
                                                  widget.newBadgeTitle,
                                                  style: const TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 10,
                                                    fontWeight: FontWeight.w700,
                                                    letterSpacing: 0.4,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 6),

                                      // Rozet adı
                                      Text(
                                        widget.badge.name,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.2,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),

                                      const SizedBox(height: 3),

                                      // Açıklama
                                      Text(
                                        widget.badge.description,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.60),
                                          fontSize: 12,
                                          height: 1.3,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 10),

                                // Sağ: Görüntüle butonu
                                GestureDetector(
                                  onTap: widget.onViewAll,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                      color:
                                          Colors.blue.shade700.withOpacity(0.4),
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.blue.shade400
                                            .withOpacity(0.45),
                                        width: 1,
                                      ),
                                    ),
                                    child: const Icon(
                                      Icons.chevron_right_rounded,
                                      color: Colors.white70,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Alt: Progress bar (4.5s timer)
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(22),
                                bottomRight: Radius.circular(22),
                              ),
                              child: AnimatedBuilder(
                                animation: _controller,
                                builder: (context, _) {
                                  return LinearProgressIndicator(
                                    value: 1.0 - _controller.value,
                                    minHeight: 3,
                                    backgroundColor:
                                        Colors.white.withOpacity(0.06),
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.amber.shade400,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Overlay Manager
// ─────────────────────────────────────────────────────────────────────────────

OverlayEntry? _currentBadgeOverlay;

void _showBadgeOverlay({
  required BuildContext context,
  required Badgee badge,
  required String newBadgeTitle,
  required VoidCallback onViewAll,
}) {
  _currentBadgeOverlay?.remove();
  _currentBadgeOverlay = null;

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (ctx) => Positioned(
      bottom: 28,
      left: 0,
      right: 0,
      child: Material(
        color: Colors.transparent,
        child: _BadgeUnlockOverlay(
          badge: badge,
          newBadgeTitle: newBadgeTitle,
          onDismiss: () {
            entry.remove();
            _currentBadgeOverlay = null;
          },
          onViewAll: () {
            entry.remove();
            _currentBadgeOverlay = null;
            onViewAll();
          },
        ),
      ),
    ),
  );

  _currentBadgeOverlay = entry;
  Overlay.of(context).insert(entry);
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
    final todayString = formatDate(today);
    final lastDate = prefs.getString('lastConsecutiveDate');

    if (lastDate == null) {
      await prefs.setInt('consecutiveDays', 1);
      await prefs.setString('lastConsecutiveDate', todayString);
      return;
    }

    if (lastDate == todayString) return;

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
  static List<Badgee> getAllBadges(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return [
      Badgee(
        id: 'first_drop',
        name: loc.badge_first_drop_name,
        description: loc.badge_first_drop_desc,
        iconData: FontAwesomeIcons.droplet,
      ),
      Badgee(
        id: 'blue_spark',
        name: loc.badge_blue_spark_name,
        description: loc.badge_blue_spark_desc,
        iconData: FontAwesomeIcons.boltLightning,
      ),
      Badgee(
        id: 'flow_starter',
        name: loc.badge_flow_starter_name,
        description: loc.badge_flow_starter_desc,
        iconData: FontAwesomeIcons.fire,
      ),
      Badgee(
        id: 'blue_energy',
        name: loc.badge_blue_energy_name,
        description: loc.badge_blue_energy_desc,
        iconData: FontAwesomeIcons.star,
      ),
      Badgee(
        id: 'water_hunter',
        name: loc.badge_water_hunter_name,
        description: loc.badge_water_hunter_desc,
        iconData: FontAwesomeIcons.bullseye,
      ),
      Badgee(
        id: 'hydro_master',
        name: loc.badge_hydro_master_name,
        description: loc.badge_hydro_master_desc,
        iconData: FontAwesomeIcons.medal,
      ),
      Badgee(
        id: 'ocean_bender',
        name: loc.badge_ocean_bender_name,
        description: loc.badge_ocean_bender_desc,
        iconData: FontAwesomeIcons.crown,
      ),
      Badgee(
        id: 'aqua_legend',
        name: loc.badge_aqua_legend_name,
        description: loc.badge_aqua_legend_desc,
        iconData: FontAwesomeIcons.trophy,
      ),
    ];
  }

  static Future<List<Badgee>> getUnlockedBadges(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final unlockedIds = prefs.getStringList('unlockedBadges') ?? [];

    return getAllBadges(context).map((badge) {
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
      if (await unlockBadge('first_drop')) newBadges.add('first_drop');
    }
    if (currentWater >= targetWater) {
      if (await unlockBadge('blue_spark')) newBadges.add('blue_spark');
    }
    if (consecutiveDays >= 5) {
      if (await unlockBadge('flow_starter')) newBadges.add('flow_starter');
    }
    if (totalDays >= 7) {
      if (await unlockBadge('blue_energy')) newBadges.add('blue_energy');
    }
    if (totalDays >= 15) {
      if (await unlockBadge('water_hunter')) newBadges.add('water_hunter');
    }
    if (totalDays >= 30) {
      if (await unlockBadge('hydro_master')) newBadges.add('hydro_master');
    }
    if (totalDays >= 90) {
      if (await unlockBadge('ocean_bender')) newBadges.add('ocean_bender');
    }
    if (totalDays >= 180) {
      if (await unlockBadge('aqua_legend')) newBadges.add('aqua_legend');
    }

    return newBadges;
  }

  static void showNewBadgeNotification(BuildContext context, String badgeId) {
    final loc = AppLocalizations.of(context)!;
    final badge = getAllBadges(context).firstWhere((b) => b.id == badgeId);

    _showBadgeOverlay(
      context: context,
      badge: badge,
      newBadgeTitle: loc.newBadgeTitle,
      onViewAll: () async {
        final badges = await getUnlockedBadges(context);
        showBadgesDialog(context, badges);
      },
    );
  }

  // Rozetler Dialog
  static void showBadgesDialog(BuildContext context, List<Badgee> badges) {
    final loc = AppLocalizations.of(context)!;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: Container(
            height: MediaQuery.of(dialogContext).size.height * 0.7,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
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
                        "Rozetlerim",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(dialogContext),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
                            Icon(
                              badge.iconData,
                              size: 40,
                              color: badge.isUnlocked
                                  ? Colors.blue.shade300
                                  : Colors.white.withOpacity(0.3),
                            ),
                            const SizedBox(height: 8),
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
                            const SizedBox(height: 4),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
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
                              const Padding(
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
