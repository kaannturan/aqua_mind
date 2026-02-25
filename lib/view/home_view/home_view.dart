// ignore_for_file: library_private_types_in_public_api, deprecated_member_use, unused_local_variable, use_build_context_synchronously, unused_element
import 'dart:math';
import 'dart:ui';
import 'package:aqua_mind/core/utils/reminder_settings_page.dart';
import 'package:aqua_mind/models/badgee_model.dart';
import 'package:aqua_mind/view/hi_view.dart';
import 'package:aqua_mind/view/language_settings.dart';
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../badges and levels/achievement_system.dart';
import 'package:aqua_mind/l10n/app_localizations.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class HomePage extends StatefulWidget {
  final int height;
  final int weight;
  final double dailyWater;
  const HomePage(
      {super.key,
      required this.dailyWater,
      required this.height,
      required this.weight});

  @override
  State<HomePage> createState() => _HomePageState();
}

DateTime safeParse(String dateStr) {
  final parts = dateStr.split("-");
  if (parts.length == 3) {
    final y = parts[0];
    final m = parts[1].padLeft(2, "0");
    final d = parts[2].padLeft(2, "0");
    return DateTime.parse("$y-$m-$d");
  }
  return DateTime.now();
}

// Drawer menü öğesi

class _DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final bool isFaIcon;
  final Color? iconColor;

  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.isFaIcon = false,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final color = iconColor ?? Colors.white70;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          splashColor: Colors.blue.withOpacity(0.12),
          highlightColor: Colors.blue.withOpacity(0.07),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
            child: Row(
              children: [
                SizedBox(
                  width: 22,
                  child: isFaIcon
                      ? FaIcon(icon, color: color, size: 18)
                      : Icon(icon, color: color, size: 22),
                ),
                const SizedBox(width: 14),
                Text(
                  label,
                  style: TextStyle(
                    color: iconColor != null ? color : Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// HomePage State
// ─────────────────────────────────────────────────────────────────────────────

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // Body alt banner
  BannerAd? _bottomBannerAd;
  bool _bottomBannerAdLoaded = false;

  InterstitialAd? _interstitialAd;

  double? waterLevel;
  int currentWater = 0;
  late int targetWater;
  late double liter;
  Map<String, double> weeklyData = {};
  final ScrollController _scrollController = ScrollController();

  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  int consecutiveDays = 0;
  List<Badgee> badges = [];

  @override
  void initState() {
    super.initState();
    targetWater = widget.dailyWater.toInt();
    liter = widget.dailyWater / 1000;

    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _loadTodayWater();

    // Body alt banner
    _bottomBannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.largeBanner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          setState(() => _bottomBannerAdLoaded = true);
        },
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          setState(() => _bottomBannerAdLoaded = false);
        },
      ),
    )..load();

    _loadInterstitialAd();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _loadLevelAndBadges();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          Future.delayed(const Duration(seconds: 5), _showInterstitialAd);
        },
        onAdFailedToLoad: (error) {},
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) return;
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdDismissedFullScreenContent: (ad) {
        ad.dispose();
        _interstitialAd = null;
      },
      onAdFailedToShowFullScreenContent: (ad, error) {
        ad.dispose();
        _interstitialAd = null;
      },
    );
    _interstitialAd!.show();
  }

  Future<void> _loadLevelAndBadges() async {
    final consecutive = await LevelSystem.getConsecutiveDays();
    final unlockedBadges = await BadgeSystem.getUnlockedBadges(context);
    if (mounted) {
      setState(() {
        consecutiveDays = consecutive;
        badges = unlockedBadges;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _progressController.dispose();
    _bottomBannerAd?.dispose();
    _interstitialAd?.dispose();
    super.dispose();
  }

  String twoDigits(int n) => n.toString().padLeft(2, "0");

  String getTodayString() {
    final today = DateTime.now();
    return "${today.year}-${twoDigits(today.month)}-${twoDigits(today.day)}";
  }

  Future<void> _loadTodayWater() async {
    final prefs = await SharedPreferences.getInstance();
    final todayString = getTodayString();
    int savedWater = prefs.getInt("todayDrankWater") ?? 0;
    final lastDate = prefs.getString("lastDrinkDate") ?? todayString;

    if (lastDate != todayString) {
      savedWater = 0;
      await prefs.setInt("todayDrankWater", 0);
    }

    final loadedWeeklyData = await _loadWeeklyWater();

    setState(() {
      currentWater = savedWater;
      waterLevel = (1.0 - (currentWater / targetWater * 0.85)).clamp(0.15, 1.0);
      weeklyData = loadedWeeklyData;
    });

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: currentWater / targetWater,
    ).animate(
        CurvedAnimation(parent: _progressController, curve: Curves.easeInOut));
    _progressController.forward();
  }

  Future<void> _saveWater() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt("todayDrankWater", currentWater);
    await prefs.setString("lastDrinkDate", getTodayString());
  }

  Future<void> _saveWeeklyWater() async {
    final prefs = await SharedPreferences.getInstance();
    final todayString = getTodayString();
    List<String> savedList = prefs.getStringList("weeklyWater") ?? [];
    Map<String, double> weekly = {};
    for (var entry in savedList) {
      final parts = entry.split(":");
      weekly[parts[0]] = double.parse(parts[1]);
    }
    weekly[todayString] = currentWater.toDouble();
    var sortedKeys = weekly.keys.toList()..sort((a, b) => b.compareTo(a));
    List<String> newList = [];
    for (int i = 0; i < min(7, sortedKeys.length); i++) {
      final key = sortedKeys[i];
      newList.add("$key:${weekly[key]}");
    }
    await prefs.setStringList("weeklyWater", newList);
  }

  Future<Map<String, double>> _loadWeeklyWater() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> savedList = prefs.getStringList("weeklyWater") ?? [];
    Map<String, double> weekly = {};
    for (var entry in savedList) {
      final parts = entry.split(":");
      weekly[parts[0]] = double.parse(parts[1]);
    }
    return weekly;
  }

  void addWater(int amount) async {
    if (currentWater >= targetWater) return;
    final scrollPosition =
        _scrollController.hasClients ? _scrollController.offset : 0.0;
    final oldProgress = currentWater / targetWater;
    setState(() {
      currentWater = (currentWater + amount).clamp(0, targetWater);
      waterLevel = (1.0 - (currentWater / targetWater * 0.85)).clamp(0.15, 1.0);
    });
    _progressAnimation =
        Tween<double>(begin: oldProgress, end: currentWater / targetWater)
            .animate(CurvedAnimation(
                parent: _progressController, curve: Curves.easeInOut));
    _progressController.forward(from: 0.0);
    await _saveWater();
    await _saveWeeklyWater();
    final todayString = getTodayString();
    await LevelSystem.addDataDate(todayString);
    await LevelSystem.updateConsecutiveDays();
    final newBadges =
        await BadgeSystem.checkAndUnlockBadges(currentWater, targetWater);
    await _loadLevelAndBadges();
    if (newBadges.isNotEmpty && mounted) {
      for (var badgeId in newBadges) {
        BadgeSystem.showNewBadgeNotification(context, badgeId);
      }
    }
    final newWeeklyData = await _loadWeeklyWater();
    if (mounted) setState(() => weeklyData = newWeeklyData);
    if (_scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients)
          _scrollController.jumpTo(scrollPosition);
      });
    }
  }

  void removeWater(int amount) async {
    final scrollPosition =
        _scrollController.hasClients ? _scrollController.offset : 0.0;
    final oldProgress = currentWater / targetWater;
    setState(() {
      currentWater = (currentWater - amount).clamp(0, targetWater);
      waterLevel = (1.0 - (currentWater / targetWater * 0.85)).clamp(0.15, 1.0);
    });
    _progressAnimation =
        Tween<double>(begin: oldProgress, end: currentWater / targetWater)
            .animate(CurvedAnimation(
                parent: _progressController, curve: Curves.easeInOut));
    _progressController.forward(from: 0.0);
    await _saveWater();
    await _saveWeeklyWater();
    final newWeeklyData = await _loadWeeklyWater();
    if (mounted) setState(() => weeklyData = newWeeklyData);
    if (_scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients)
          _scrollController.jumpTo(scrollPosition);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    if (waterLevel == null) {
      return Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Color(0xff062549)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: const Center(
              child: CircularProgressIndicator(color: Colors.blueAccent)),
        ),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 13),
            child: IconButton(
              icon: const Icon(FontAwesomeIcons.solidBell,
                  size: 22, color: Colors.white70),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ReminderSettingsPage()),
              ),
            ),
          ),
        ],
        iconTheme: const IconThemeData(color: Colors.white70),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "AquaMind",
          style: TextStyle(
              color: Colors.white70,
              fontSize: width * 0.06,
              fontWeight: FontWeight.bold),
        ),
      ),

      // ── DRAWER ──────────────────────────────────────────────────────────
      drawer: SizedBox(
        width: 260,
        child: Drawer(
          backgroundColor: Colors.transparent,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF050E1A), Color(0xFF062549)],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                // Header
                Container(
                  height: height * 0.20,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Color(0xFF0A2040)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    border: Border(
                      bottom: BorderSide(color: Color(0x33429CE8), width: 1),
                    ),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 48, 20, 20),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade700
                            ],
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade500.withOpacity(0.4),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.water_drop_rounded,
                            color: Colors.white, size: 22),
                      ),
                      const SizedBox(width: 12),
                      const Text(
                        'AquaMind',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                _DrawerItem(
                  icon: Icons.home_rounded,
                  label: loc.home,
                  onTap: () => Navigator.pop(context),
                ),
                _DrawerItem(
                  icon: FontAwesomeIcons.solidBell,
                  label: loc.reminder,
                  isFaIcon: true,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReminderSettingsPage()),
                  ),
                ),
                _DrawerItem(
                  icon: Icons.mail_rounded,
                  label: loc.feedback,
                  onTap: () => showGeneralDialog(
                    context: context,
                    barrierDismissible: true,
                    barrierLabel: '',
                    barrierColor: Colors.black.withOpacity(0.6),
                    transitionDuration: const Duration(milliseconds: 350),
                    transitionBuilder:
                        (context, animation, secondaryAnimation, child) {
                      final curved = CurvedAnimation(
                        parent: animation,
                        curve: Curves.easeOutBack,
                      );
                      return ScaleTransition(
                        scale: Tween<double>(begin: 0.85, end: 1.0)
                            .animate(curved),
                        child: FadeTransition(
                          opacity: animation,
                          child: child,
                        ),
                      );
                    },
                    pageBuilder: (context, animation, secondaryAnimation) {
                      return Center(
                        child: Material(
                          color: Colors.transparent,
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 28),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(24),
                              gradient: const LinearGradient(
                                colors: [Color(0xFF0D1F35), Color(0xFF062549)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              border: Border.all(
                                color: Colors.blue.shade300.withOpacity(0.25),
                                width: 1.2,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.shade900.withOpacity(0.5),
                                  blurRadius: 32,
                                  spreadRadius: 4,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(24),
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                                child: Padding(
                                  padding: const EdgeInsets.all(28),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Icon badge
                                      Container(
                                        width: 60,
                                        height: 60,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.blue.shade400,
                                              Colors.blue.shade700,
                                            ],
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Colors.blue.shade500
                                                  .withOpacity(0.02),
                                              blurRadius: 18,
                                              spreadRadius: 2,
                                            ),
                                          ],
                                        ),
                                        child: const Icon(
                                          Icons.mail_rounded,
                                          color: Colors.white,
                                          size: 28,
                                        ),
                                      ),

                                      const SizedBox(height: 18),

                                      // Title

                                      Text(
                                        loc.feedbackTitle,
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -0.3,
                                        ),
                                      ),

                                      const SizedBox(height: 10),

                                      // Divider
                                      Container(
                                        height: 1,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            colors: [
                                              Colors.transparent,
                                              Colors.blue.shade300
                                                  .withOpacity(0.4),
                                              Colors.transparent,
                                            ],
                                          ),
                                        ),
                                      ),

                                      const SizedBox(height: 14),

                                      // Content
                                      Text(
                                        loc.feedbackContent,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white.withOpacity(0.7),
                                          fontSize: 14,
                                          height: 1.55,
                                        ),
                                      ),

                                      const SizedBox(height: 26),

                                      // Close button
                                      SizedBox(
                                        width: double.infinity,
                                        child: TextButton(
                                          onPressed: () =>
                                              Navigator.pop(context),
                                          style: TextButton.styleFrom(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 14),
                                            backgroundColor: Colors
                                                .blue.shade700
                                                .withOpacity(0.35),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(14),
                                              side: BorderSide(
                                                color: Colors.blue.shade400
                                                    .withOpacity(0.4),
                                                width: 1,
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            "Close",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                              fontWeight: FontWeight.w600,
                                            ),
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
                      );
                    },
                  ),
                ),
                _DrawerItem(
                  icon: Icons.language_rounded,
                  label: loc.languageSettings,
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LanguageSettingsPage()),
                  ),
                ),

                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Divider(
                      color: Colors.blue.shade300.withOpacity(0.15), height: 1),
                ),

                _DrawerItem(
                  icon: Icons.restart_alt_rounded,
                  label: loc.resetApp,
                  iconColor: Colors.red.shade300,
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    for (var key in [
                      "completedSetup",
                      "dailyWater",
                      "height",
                      "weight",
                      "gender",
                      "todayDrankWater",
                      "lastDrinkDate",
                      "weeklyWater"
                    ]) {
                      await prefs.remove(key);
                    }
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HiPage()),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 10),
                  child: Text(
                    '2026©AquaMind',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.50),
                      fontSize: 11,
                      letterSpacing: 0.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // ── BODY ────────────────────────────────────────────────────────────
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/dropletback.png"),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                colors: [Colors.black, Color(0xff062549)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          SafeArea(
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 5.0),
                                child: Icon(FontAwesomeIcons.person,
                                    color: Colors.blue.shade300,
                                    size: width * 0.06),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.blue.withOpacity(0.6),
                                ),
                                height: height * 0.05,
                                width: width * 0.60,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 5.0, top: 2.0),
                                  child: Text(
                                    loc.drinkRecommendation,
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 13),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        TextButton(
                          onPressed: () =>
                              BadgeSystem.showBadgesDialog(context, badges),
                          child: Row(
                            children: [
                              Text(
                                "${badges.where((b) => b.isUnlocked).length}/${badges.length}",
                                style: const TextStyle(
                                    color: Colors.white, fontSize: 14),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 6.0),
                                child: Icon(FontAwesomeIcons.award,
                                    color: Colors.amber, size: 14),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      ClipPath(
                        clipper: WaterDropClipper(),
                        child: SizedBox(
                          width: width,
                          height: height * 0.5,
                          child: WaterWaveFill(waterLevel: waterLevel!),
                        ),
                      ),
                      CustomPaint(
                        size: Size(width, height * 0.5),
                        painter: WaterStack(),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.03),
                  Text("  $currentWater / $targetWater ml   ",
                      style: const TextStyle(color: Colors.white70)),
                  SizedBox(height: height * 0.006),
                  Text(
                    " ${loc.dailyTarget}$targetWater ml",
                    style: TextStyle(
                        fontSize: width * 0.05,
                        color: Colors.white70,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _waterButton(
                        width: width,
                        height: height,
                        icon: FontAwesomeIcons.whiskeyGlass,
                        label: "100 ml",
                        color: Colors.blue,
                        onTap: currentWater >= targetWater
                            ? null
                            : () => addWater(100),
                      ),
                      _waterButton(
                        width: width,
                        height: height,
                        icon: FontAwesomeIcons.glassWater,
                        label: "200 ml",
                        color: Colors.blue,
                        onTap: currentWater >= targetWater
                            ? null
                            : () => addWater(200),
                      ),
                      _waterButton(
                        width: width,
                        height: height,
                        icon: FontAwesomeIcons.bottleWater,
                        label: "500 ml",
                        color: Colors.blue,
                        onTap: currentWater >= targetWater
                            ? null
                            : () => addWater(500),
                      ),
                      _waterButton(
                        width: width,
                        height: height,
                        icon: FontAwesomeIcons.downLong,
                        label: "100 ml",
                        color: Colors.red,
                        onTap: () => removeWater(100),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.01),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(loc.todayProgress,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 12),
                        _infoRow(loc.drunkWater, "$currentWater ml"),
                        const SizedBox(height: 8),
                        _infoRow(loc.dailyGoalLabel, "$targetWater ml"),
                        const SizedBox(height: 8),
                        _infoRow(loc.remaining,
                            "${(targetWater - currentWater).clamp(0, targetWater)} ml"),
                        const SizedBox(height: 18),
                        AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) {
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Stack(
                                children: [
                                  Container(
                                    height: 12,
                                    decoration: BoxDecoration(
                                      color: Colors.white12,
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                  ),
                                  FractionallySizedBox(
                                    widthFactor: _progressAnimation.value
                                        .clamp(0.0, 1.0),
                                    child: Container(
                                      height: 12,
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: [
                                          Colors.blueAccent,
                                          Colors.blue.shade300,
                                        ]),
                                        borderRadius: BorderRadius.circular(12),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.blueAccent
                                                .withOpacity(0.4),
                                            blurRadius: 8,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 8),
                        AnimatedBuilder(
                          animation: _progressAnimation,
                          builder: (context, child) => Center(
                            child: Text(
                              loc.completedPercent(
                                  (_progressAnimation.value * 100)
                                      .clamp(0, 100)
                                      .toInt()),
                              style: const TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        WeeklyWaterContainer(
                            weeklyData: weeklyData, targetWater: targetWater),
                      ],
                    ),
                  ),

                  // Body alt banner — sadece yüklenince göster
                  if (_bottomBannerAd != null && _bottomBannerAdLoaded)
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: _bottomBannerAd!.size.height.toDouble(),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.blue.shade300, width: 2),
                      ),
                      child: AdWidget(ad: _bottomBannerAd!),
                    ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _waterButton({
    required double width,
    required double height,
    required IconData icon,
    required String label,
    required Color color,
    VoidCallback? onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(60),
        child: Container(
          width: width * 0.15,
          height: height * 0.08,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white, size: 20),
              const SizedBox(height: 8),
              Text(label,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(color: Colors.white70, fontSize: 16)),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontSize: 17,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// WeeklyWaterContainer
// ─────────────────────────────────────────────────────────────────────────────

class WeeklyWaterContainer extends StatelessWidget {
  final Map<String, double> weeklyData;
  final int targetWater;

  const WeeklyWaterContainer({
    super.key,
    required this.weeklyData,
    required this.targetWater,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;
    final width = size.width;

    final days = [
      loc.weekDayMon,
      loc.weekDayTue,
      loc.weekDayWed,
      loc.weekDayThu,
      loc.weekDayFri,
      loc.weekDaySat,
      loc.weekDaySun,
    ];

    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final thisWeekMonday =
        DateTime(weekStart.year, weekStart.month, weekStart.day);
    final thisWeekSunday = thisWeekMonday.add(const Duration(days: 6));

    Map<int, double> dailyMap = {};
    for (var entry in weeklyData.entries) {
      final date = safeParse(entry.key);
      final dateOnly = DateTime(date.year, date.month, date.day);
      if (!dateOnly.isBefore(thisWeekMonday) &&
          !dateOnly.isAfter(thisWeekSunday)) {
        dailyMap[date.weekday - 1] = entry.value;
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            padding: const EdgeInsets.all(16),
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white24),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(loc.weeklyWaterTracking,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: List.generate(7, (index) {
                      final drank = dailyMap[index] ?? 0.0;
                      final barHeight =
                          (drank / targetWater * 100).clamp(0.0, 100.0);
                      final isCompleted = drank >= targetWater;
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          if (isCompleted)
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.green.shade400,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.green.withOpacity(0.1),
                                      blurRadius: 8,
                                      spreadRadius: 1),
                                ],
                              ),
                              child: const Icon(Icons.check,
                                  color: Colors.white, size: 14),
                            )
                          else
                            const SizedBox(height: 5),
                          const SizedBox(height: 4),
                          Container(
                            width: width * 0.03,
                            height: barHeight * 0.8,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isCompleted
                                    ? [
                                        Colors.blue.shade600,
                                        Colors.blue.shade300
                                      ]
                                    : [Colors.blueAccent, Colors.blue.shade200],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: isCompleted
                                  ? [
                                      BoxShadow(
                                          color: Colors.blue.withOpacity(0.4),
                                          blurRadius: 6,
                                          spreadRadius: 1)
                                    ]
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            days[index],
                            style: TextStyle(
                              color: isCompleted
                                  ? Colors.blue.shade200
                                  : Colors.white70,
                              fontSize: 12,
                              fontWeight: isCompleted
                                  ? FontWeight.bold
                                  : FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// Painter & Clipper
// ─────────────────────────────────────────────────────────────────────────────

class WaterDropClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.05);
    path.cubicTo(size.width * 0.65, size.height * 0.60, size.width * 1.05,
        size.height * 0.78, size.width * 0.50, size.height * 1.00);
    path.cubicTo(size.width * -0.05, size.height * 0.78, size.width * 0.35,
        size.height * 0.60, size.width * 0.50, size.height * 0.05);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) => false;
}

class WaterStack extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.05);
    path.cubicTo(size.width * 0.65, size.height * 0.60, size.width * 1.05,
        size.height * 0.78, size.width * 0.50, size.height * 1.00);
    path.cubicTo(size.width * -0.05, size.height * 0.78, size.width * 0.35,
        size.height * 0.60, size.width * 0.50, size.height * 0.05);
    path.close();
    final paint = Paint()
      ..color = Colors.blue.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class WaterWaveFill extends StatefulWidget {
  final double waterLevel;
  const WaterWaveFill({super.key, required this.waterLevel});

  @override
  _WaterWaveFillState createState() => _WaterWaveFillState();
}

class _WaterWaveFillState extends State<WaterWaveFill>
    with TickerProviderStateMixin {
  late AnimationController _backController;
  late AnimationController _frontController;
  late AnimationController _levelController;
  late Animation<double> _levelAnimation;
  late double _currentLevel;

  @override
  void initState() {
    super.initState();
    _currentLevel = widget.waterLevel;
    _backController =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..repeat();
    _frontController =
        AnimationController(vsync: this, duration: const Duration(seconds: 4))
          ..repeat();
    _levelController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 800));
    _levelAnimation =
        Tween<double>(begin: _currentLevel, end: widget.waterLevel).animate(
            CurvedAnimation(parent: _levelController, curve: Curves.easeInOut));
  }

  @override
  void didUpdateWidget(WaterWaveFill oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.waterLevel != widget.waterLevel) {
      double startLevel =
          _levelController.isAnimating ? _levelAnimation.value : _currentLevel;
      _levelAnimation = Tween<double>(begin: startLevel, end: widget.waterLevel)
          .animate(CurvedAnimation(
              parent: _levelController, curve: Curves.easeInOut));
      _levelController.reset();
      _levelController.forward().then((_) => _currentLevel = widget.waterLevel);
    }
  }

  @override
  void dispose() {
    _backController.dispose();
    _frontController.dispose();
    _levelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge(
          [_backController, _frontController, _levelAnimation]),
      builder: (context, child) => CustomPaint(
        painter: WavePainter(_backController.value, _frontController.value,
            _levelAnimation.value),
      ),
    );
  }
}

class WavePainter extends CustomPainter {
  final double backValue;
  final double frontValue;
  final double waterLevel;
  WavePainter(this.backValue, this.frontValue, this.waterLevel);

  @override
  void paint(Canvas canvas, Size size) {
    final bgPaint = Paint()
      ..shader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [Colors.white, Colors.blue.shade200],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    final shadowPaint = Paint()
      ..color = Colors.blue.shade900.withOpacity(0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20);

    final backWavePaint = Paint()
      ..color = Colors.blue.shade700.withOpacity(0.9)
      ..style = PaintingStyle.fill;

    final frontWavePaint = Paint()
      ..color = Colors.blue.shade700.withOpacity(0.9)
      ..style = PaintingStyle.fill;

    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final double baseHeight = size.height * waterLevel;
    final double backPhase = backValue * 2 * 3.14;
    final double frontPhase = frontValue * 2 * 3.14;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final backWave = Path()..moveTo(0, baseHeight);
    for (double x = 0; x <= size.width; x++) {
      backWave.lineTo(
          x, baseHeight + sin((x / size.width * 2 * 3.14) + backPhase) * 14);
    }
    backWave
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(backWave, shadowPaint);
    canvas.drawPath(backWave, backWavePaint);

    final frontWave = Path()..moveTo(0, baseHeight - 8);
    for (double x = 0; x <= size.width; x++) {
      frontWave.lineTo(
          x,
          (baseHeight - 8) +
              sin((x / size.width * 2 * 3.14) + frontPhase) * 14);
    }
    frontWave
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(frontWave, frontWavePaint);
    canvas.drawPath(frontWave, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) => true;
}
