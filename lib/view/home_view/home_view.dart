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

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  BannerAd? _bannerAd;
  BannerAd? _bottomBannerAd;
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
      duration: Duration(milliseconds: 200),
    );

    _progressAnimation = Tween<double>(begin: 0.0, end: 0.0).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );

    _loadTodayWater();
    _loadLevelAndBadges();

    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.banner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print('Drawer reklamı yüklendi');
          setState(() {});
        },
        onAdFailedToLoad: (ad, error) {
          print('Drawer reklamı hatası: $error');
          ad.dispose();
        },
      ),
    )..load();

    _bottomBannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/6300978111',
      size: AdSize.largeBanner,
      request: AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          print('Alt reklam yüklendi');
          setState(() {});
        },
        onAdFailedToLoad: (ad, error) {
          print('Alt reklam hatası: $error');
          ad.dispose();
        },
      ),
    )..load();

    _loadInterstitialAd();
  }

  void _loadInterstitialAd() {
    InterstitialAd.load(
      adUnitId: 'ca-app-pub-3940256099942544/1033173712',
      request: AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          print('Tam ekran reklam yüklendi');
          _interstitialAd = ad;
          Future.delayed(Duration(seconds: 5), () {
            _showInterstitialAd();
          });
        },
        onAdFailedToLoad: (error) {
          print('Tam ekran reklam hatası: $error');
        },
      ),
    );
  }

  void _showInterstitialAd() {
    if (_interstitialAd != null) {
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
  }

  Future<void> _loadLevelAndBadges() async {
    final level = await LevelSystem.getCurrentLevel();
    final consecutive = await LevelSystem.getConsecutiveDays();
    final unlockedBadges = await BadgeSystem.getUnlockedBadges();

    setState(() {
      consecutiveDays = consecutive;
      badges = unlockedBadges;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _progressController.dispose();
    _bannerAd?.dispose();
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
      waterLevel = 1.0 - (currentWater / targetWater * 0.85);
      waterLevel = waterLevel!.clamp(0.15, 1.0);
      weeklyData = loadedWeeklyData;
    });

    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: currentWater / targetWater,
    ).animate(
      CurvedAnimation(parent: _progressController, curve: Curves.easeInOut),
    );
    _progressController.forward();
  }

  Future<void> _saveWater() async {
    final prefs = await SharedPreferences.getInstance();
    final todayString = getTodayString();
    await prefs.setInt("todayDrankWater", currentWater);
    await prefs.setString("lastDrinkDate", todayString);
  }

  Future<void> _saveWeeklyWater() async {
    final prefs = await SharedPreferences.getInstance();
    final today = DateTime.now();
    final todayString = getTodayString();

    List<String> savedList = prefs.getStringList("weeklyWater") ?? [];

    Map<String, double> weekly = {};
    for (var entry in savedList) {
      final parts = entry.split(":");
      weekly[parts[0]] = double.parse(parts[1]);
    }

    weekly[todayString] = currentWater.toDouble();
    List<String> newList = [];
    var sortedKeys = weekly.keys.toList()..sort((a, b) => b.compareTo(a));
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
      waterLevel = 1.0 - (currentWater / targetWater * 0.85);
      waterLevel = waterLevel!.clamp(0.15, 1.0);
    });

    final newProgress = currentWater / targetWater;
    _progressAnimation = Tween<double>(
      begin: oldProgress,
      end: newProgress,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

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

    if (mounted) {
      setState(() {
        weeklyData = newWeeklyData;
      });
    }

    if (_scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(scrollPosition);
        }
      });
    }
  }

  void removeWater(int amount) async {
    final scrollPosition =
        _scrollController.hasClients ? _scrollController.offset : 0.0;

    final oldProgress = currentWater / targetWater;

    setState(() {
      currentWater = (currentWater - amount).clamp(0, targetWater);
      waterLevel = 1.0 - (currentWater / targetWater * 0.85);
      waterLevel = waterLevel!.clamp(0.15, 1.0);
    });

    final newProgress = currentWater / targetWater;
    _progressAnimation = Tween<double>(
      begin: oldProgress,
      end: newProgress,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    _progressController.forward(from: 0.0);

    await _saveWater();
    await _saveWeeklyWater();

    final newWeeklyData = await _loadWeeklyWater();

    if (mounted) {
      setState(() {
        weeklyData = newWeeklyData;
      });
    }

    if (_scrollController.hasClients) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.jumpTo(scrollPosition);
        }
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
          child: Center(
            child: CircularProgressIndicator(color: Colors.blueAccent),
          ),
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
              icon: const Icon(
                FontAwesomeIcons.solidBell,
                size: 22,
                color: Colors.white70,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ReminderSettingsPage(),
                  ),
                );
              },
            ),
          ),
        ],
        iconTheme: IconThemeData(color: Colors.white70),
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "AquaMind",
          style: TextStyle(
            color: Colors.white70,
            fontSize: width * 0.06,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      drawer: SizedBox(
        width: 250,
        child: Drawer(
          backgroundColor: const Color(0xFF062549),
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Color(0xff062549),
                  Color(0xff062549),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                SizedBox(
                  height: height * 0.17,
                  child: DrawerHeader(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black,
                          Color(0xff062549),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: const Text(
                      'AquaMind',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 23,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  textColor: Colors.white,
                  leading: const Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  title: Text(loc.home),
                  onTap: () => Navigator.pop(context),
                ),
                ListTile(
                  textColor: Colors.white,
                  leading: const Icon(
                    FontAwesomeIcons.solidBell,
                    color: Colors.white,
                  ),
                  title: Text(loc.reminder),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ReminderSettingsPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  textColor: Colors.white,
                  leading: const Icon(
                    Icons.mail,
                    color: Colors.white,
                  ),
                  title: Text(loc.feedback),
                  onTap: () => showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: Text(loc.feedbackTitle),
                            content: Text(loc.feedbackContent),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: Text("Close"),
                              ),
                            ],
                          )),
                ),
                ListTile(
                  leading: Icon(Icons.language, color: Colors.white),
                  title: Text(
                    loc.languageSettings,
                    style: TextStyle(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LanguageSettingsPage(),
                      ),
                    );
                  },
                ),
                ListTile(
                  textColor: Colors.white,
                  leading: const Icon(
                    Icons.restart_alt,
                    color: Colors.white,
                  ),
                  title: Text(loc.resetApp),
                  onTap: () async {
                    final prefs = await SharedPreferences.getInstance();
                    await prefs.remove("completedSetup");
                    await prefs.remove("dailyWater");
                    await prefs.remove("height");
                    await prefs.remove("weight");
                    await prefs.remove("gender");
                    await prefs.remove("todayDrankWater");
                    await prefs.remove("lastDrinkDate");
                    await prefs.remove("weeklyWater");

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const HiPage()),
                    );
                  },
                ),
                if (_bannerAd != null)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    alignment: Alignment.center,
                    color: Colors.transparent,
                    width: _bannerAd!.size.width.toDouble(),
                    height: _bannerAd!.size.height.toDouble(),
                    child: AdWidget(ad: _bannerAd!),
                  ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      "2026@AquaMind",
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                  ],
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/images/dropletback.png",
                  ),
                  fit: BoxFit.cover),
              gradient: LinearGradient(
                colors: [
                  Colors.black,
                  Color(0xff062549),
                ],
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
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 5.0, left: 0),
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Icon(
                                        FontAwesomeIcons.person,
                                        color: Colors.blue.shade300,
                                        size: width * 0.06,
                                      ),
                                    ),
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
                                          left: 8.0,
                                          right: 5.0,
                                          top: 2.0,
                                          bottom: 0.0),
                                      child: Text(
                                        loc.drinkRecommendation,
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 13),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            TextButton(
                              onPressed: () {
                                BadgeSystem.showBadgesDialog(context, badges);
                              },
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        right: 0, left: 0),
                                    child: Text(
                                      "${badges.where((b) => b.isUnlocked).length}/${badges.length}",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 14),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 6.0),
                                    child: Icon(
                                      FontAwesomeIcons.award,
                                      color: Colors.amber,
                                      size: 14,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Column(
                    children: [
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
                    ],
                  ),
                  SizedBox(height: height * 0.03),
                  Text(
                    "  $currentWater / $targetWater ml   ",
                    style: TextStyle(color: Colors.white70),
                  ),
                  SizedBox(height: height * 0.006),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        " ${loc.dailyTarget}$targetWater ml",
                        style: TextStyle(
                          fontSize: width * 0.05,
                          color: Colors.white70,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: height * 0.02),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(23),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: currentWater >= targetWater
                                ? null
                                : () => addWater(100),
                            borderRadius: BorderRadius.circular(60),
                            child: Container(
                              width: width * 0.15,
                              height: height * 0.08,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.blue,
                                    Colors.blue,
                                  ],
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.whiskeyGlass,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "100 ml",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: currentWater >= targetWater
                                ? null
                                : () => addWater(200),
                            borderRadius: BorderRadius.circular(60),
                            child: Container(
                              width: width * 0.15,
                              height: height * 0.08,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: AlignmentGeometry.topLeft,
                                  end: AlignmentGeometry.bottomRight,
                                  colors: [
                                    Colors.blue,
                                    Colors.blue,
                                  ],
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.glassWater,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "200 ml",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: currentWater >= targetWater
                                ? null
                                : () => addWater(500),
                            borderRadius: BorderRadius.circular(60),
                            child: Container(
                              width: width * 0.15,
                              height: height * 0.08,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.blue,
                                    Colors.blue,
                                  ],
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.bottleWater,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "500 ml",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(60),
                            onTap: () => removeWater(100),
                            child: Container(
                              width: width * 0.15,
                              height: height * 0.08,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    Colors.red,
                                    Colors.red,
                                  ],
                                ),
                                shape: BoxShape.circle,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    FontAwesomeIcons.downLong,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    "100 ml",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.01,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          loc.todayProgress,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              loc.drunkWater,
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            ),
                            Text(
                              "$currentWater ml",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              loc.dailyGoalLabel,
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            ),
                            Text(
                              "$targetWater ml",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              loc.remaining,
                              style: TextStyle(
                                  color: Colors.white70, fontSize: 16),
                            ),
                            Text(
                              "${(targetWater - currentWater).clamp(0, targetWater)} ml",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
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
                                        gradient: LinearGradient(
                                          colors: [
                                            Colors.blueAccent,
                                            Colors.blue.shade300,
                                          ],
                                        ),
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
                          builder: (context, child) {
                            return Center(
                              child: Text(
                                loc.completedPercent(
                                    (_progressAnimation.value * 100)
                                        .clamp(0, 100)
                                        .toInt()),
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        WeeklyWaterContainer(
                          weeklyData: weeklyData,
                          targetWater: targetWater,
                        ),
                      ],
                    ),
                  ),
                  if (_bottomBannerAd != null)
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      alignment: Alignment.center,
                      width: _bottomBannerAd!.size.width.toDouble(),
                      height: _bottomBannerAd!.size.height.toDouble(),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.blue.shade300, width: 2),
                      ),
                      child: AdWidget(ad: _bottomBannerAd!),
                    ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Haftalık veriyi haftaya göre filtreler
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

    final days = ["Pzt", "Sal", "Çar", "Per", "Cum", "Cmt", "Paz"];

    // Bu haftanın pazartesisini hesapla
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final thisWeekMonday =
        DateTime(weekStart.year, weekStart.month, weekStart.day);
    final thisWeekSunday = thisWeekMonday.add(const Duration(days: 6));

    Map<String, double> dailyMap = {};
    for (var entry in weeklyData.entries) {
      final date = safeParse(entry.key);
      final dateOnly = DateTime(date.year, date.month, date.day);

      // Sadece bu haftaya ait verileri göster
      if (!dateOnly.isBefore(thisWeekMonday) &&
          !dateOnly.isAfter(thisWeekSunday)) {
        final weekdayIndex = date.weekday - 1; // 0=Pzt, 6=Paz
        dailyMap[days[weekdayIndex]] = entry.value;
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
                Text(
                  loc.weeklyWaterTracking,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: days.map((day) {
                      final drank = dailyMap[day] ?? 0.0;
                      final barHeight =
                          (drank / targetWater * 100).clamp(0, 100);
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
                                    spreadRadius: 1,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.check,
                                color: Colors.white,
                                size: 14,
                              ),
                            )
                          else
                            SizedBox(height: 5),
                          const SizedBox(height: 4),
                          Container(
                            width: width * 0.03,
                            height: barHeight * 0.8,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: isCompleted
                                    ? [
                                        Colors.blue.shade600,
                                        Colors.blue.shade300,
                                      ]
                                    : [
                                        Colors.blueAccent,
                                        Colors.blue.shade200,
                                      ],
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                              ),
                              borderRadius: BorderRadius.circular(6),
                              boxShadow: isCompleted
                                  ? [
                                      BoxShadow(
                                        color: Colors.blue.withOpacity(0.4),
                                        blurRadius: 6,
                                        spreadRadius: 1,
                                      ),
                                    ]
                                  : null,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            day,
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
                    }).toList(),
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

class WaterDropClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width * 0.5, size.height * 0.05);

    path.cubicTo(
      size.width * 0.65,
      size.height * 0.60,
      size.width * 1.05,
      size.height * 0.78,
      size.width * 0.50,
      size.height * 1.00,
    );

    path.cubicTo(
      size.width * -0.05,
      size.height * 0.78,
      size.width * 0.35,
      size.height * 0.60,
      size.width * 0.50,
      size.height * 0.05,
    );

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

    path.cubicTo(
      size.width * 0.65,
      size.height * 0.60,
      size.width * 1.05,
      size.height * 0.78,
      size.width * 0.50,
      size.height * 1.00,
    );

    path.cubicTo(
      size.width * -0.05,
      size.height * 0.78,
      size.width * 0.35,
      size.height * 0.60,
      size.width * 0.50,
      size.height * 0.05,
    );

    path.close();

    final cizgiStili = Paint()
      ..color = Colors.blue.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = 6;

    canvas.drawPath(path, cizgiStili);
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
    _backController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
    _frontController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 4),
    )..repeat();

    _levelController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _levelAnimation = Tween<double>(
      begin: _currentLevel,
      end: widget.waterLevel,
    ).animate(CurvedAnimation(
      parent: _levelController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void didUpdateWidget(WaterWaveFill oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.waterLevel != widget.waterLevel) {
      double startlevel =
          _levelController.isAnimating ? _levelAnimation.value : _currentLevel;
      _levelAnimation = Tween<double>(
        begin: startlevel,
        end: widget.waterLevel,
      ).animate(CurvedAnimation(
        parent: _levelController,
        curve: Curves.easeInOut,
      ));

      _levelController.reset();
      _levelController.forward().then((_) {
        _currentLevel = widget.waterLevel;
      });
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
        [_backController, _frontController, _levelAnimation],
      ),
      builder: (context, child) {
        return CustomPaint(
          painter: WavePainter(
            _backController.value,
            _frontController.value,
            _levelAnimation.value,
          ),
        );
      },
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
        colors: [
          Colors.white,
          Colors.blue.shade200,
        ],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));
    final shadowPaint = Paint()
      ..color = Colors.blue.shade900.withOpacity(0.25)
      ..maskFilter = MaskFilter.blur(BlurStyle.normal, 20);

    final backWavePaint = Paint()
      ..color = Colors.blue.shade700.withOpacity(0.9)
      ..style = PaintingStyle.fill;

    final frontWavePaint = Paint()
      ..color = Colors.blue.shade700.withOpacity(0.9)
      ..style = PaintingStyle.fill;

    double baseHeight = size.height * waterLevel;

    double backPhase = backValue * 2 * 3.14;
    double frontPhase = frontValue * 2 * 3.14;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), bgPaint);

    final backWave = Path()..moveTo(0, baseHeight);
    for (double x = 0; x <= size.width; x++) {
      double y = baseHeight + sin((x / size.width * 2 * 3.14) + backPhase) * 14;
      backWave.lineTo(x, y);
    }
    backWave.lineTo(size.width, size.height);
    backWave.lineTo(0, size.height);
    backWave.close();

    canvas.drawPath(backWave, shadowPaint);
    canvas.drawPath(backWave, backWavePaint);

    final frontWave = Path()..moveTo(0, baseHeight - 8);
    for (double x = 0; x <= size.width; x++) {
      double y =
          (baseHeight - 8) + sin((x / size.width * 2 * 3.14) + frontPhase) * 14;
      frontWave.lineTo(x, y);
    }
    frontWave.lineTo(size.width, size.height);
    frontWave.lineTo(0, size.height);
    frontWave.close();

    final highlightPaint = Paint()
      ..color = Colors.white.withOpacity(0.25)
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    canvas.drawPath(frontWave, frontWavePaint);
    canvas.drawPath(frontWave, highlightPaint);
  }

  @override
  bool shouldRepaint(covariant WavePainter oldDelegate) => true;
}
