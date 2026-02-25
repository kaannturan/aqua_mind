// ignore_for_file: unused_element, unused_local_variable

import 'package:aqua_mind/core/service/notification_service.dart';
import 'package:aqua_mind/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

// ─────────────────────────────────────────────────────────────────────────────
// DRUM SCROLL TIME PICKER
// ─────────────────────────────────────────────────────────────────────────────

Future<String?> _showDrumTimePicker(BuildContext context) {
  return showDialog<String>(
    context: context,
    barrierColor: Colors.black.withOpacity(0.72),
    builder: (_) => const _DrumTimePickerDialog(),
  );
}

class _DrumTimePickerDialog extends StatefulWidget {
  const _DrumTimePickerDialog();

  @override
  State<_DrumTimePickerDialog> createState() => _DrumTimePickerDialogState();
}

class _DrumTimePickerDialogState extends State<_DrumTimePickerDialog>
    with SingleTickerProviderStateMixin {
  late int _hour;
  late int _minute;

  late FixedExtentScrollController _hourCtrl;
  late FixedExtentScrollController _minCtrl;

  late AnimationController _entryCtrl;
  late Animation<double> _entryScale;
  late Animation<double> _entryFade;

  static const double _itemExtent = 58.0;
  static const int _hourCount = 24;
  static const int _minCount = 60;

  @override
  void initState() {
    super.initState();
    final now = TimeOfDay.now();
    _hour = now.hour;
    _minute = now.minute;

    // Sonsuz scroll için büyük offset — gerçek değer ortasında başlasın
    final hourOffset = _hourCount * 500 + _hour;
    final minOffset = _minCount * 500 + _minute;

    _hourCtrl = FixedExtentScrollController(initialItem: hourOffset);
    _minCtrl = FixedExtentScrollController(initialItem: minOffset);

    _entryCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 360),
    );
    _entryScale =
        CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOutBack);
    _entryFade = CurvedAnimation(parent: _entryCtrl, curve: Curves.easeOut);
    _entryCtrl.forward();
  }

  @override
  void dispose() {
    _entryCtrl.dispose();
    _hourCtrl.dispose();
    _minCtrl.dispose();
    super.dispose();
  }

  String get _timeString =>
      '${_hour.toString().padLeft(2, '0')}:${_minute.toString().padLeft(2, '0')}';

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _entryFade,
      child: ScaleTransition(
        scale: _entryScale,
        child: Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          insetPadding: const EdgeInsets.symmetric(horizontal: 28),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0A1628), Color(0xFF062549)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(32),
              border: Border.all(
                color: Colors.blue.shade300.withOpacity(0.22),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade900.withOpacity(0.55),
                  blurRadius: 60,
                  spreadRadius: 2,
                  offset: const Offset(0, 20),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // ── Header ─────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade700,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.shade500.withOpacity(0.25),
                              blurRadius: 14,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Icon(
                          FontAwesomeIcons.solidBell,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Hatırlatıcı Ekle',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: -0.3,
                            ),
                          ),
                          Text(
                            'Kaydırarak saat seçin',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.blue.shade200.withOpacity(0.65),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // ── Live Preview ────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: Colors.blue.shade300.withOpacity(0.18),
                        width: 1,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        _timeString,
                        style: TextStyle(
                          fontSize: 52,
                          fontWeight: FontWeight.w200,
                          color: Colors.blue.shade100,
                          letterSpacing: 6,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ── Kolon başlıkları ────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    children: [
                      Expanded(
                        child: Center(
                          child: Text(
                            'SAAT',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.blue.shade300.withOpacity(0.7),
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        child: Center(
                          child: Text(
                            'DAKİKA',
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              color: Colors.blue.shade300.withOpacity(0.7),
                              letterSpacing: 2,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 8),

                // ── Drum Picker ─────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: SizedBox(
                    height: 230,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Seçim bandı
                        Positioned(
                          child: Container(
                            height: _itemExtent,
                            margin: const EdgeInsets.symmetric(horizontal: 0),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.blue.withOpacity(0.50),
                                  Colors.blue.withOpacity(0.1),
                                ],
                              ),
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: Colors.blue.shade300.withOpacity(0.35),
                                width: 1,
                              ),
                            ),
                          ),
                        ),

                        // Picker kolonları
                        Row(
                          children: [
                            // ── Saat ──────────────────────────────────
                            Expanded(
                              child: _DrumColumn(
                                controller: _hourCtrl,
                                itemCount: _hourCount,
                                selectedValue: _hour,
                                itemExtent: _itemExtent,
                                onChanged: (rawIndex) {
                                  HapticFeedback.selectionClick();
                                  setState(() {
                                    _hour = rawIndex % _hourCount;
                                  });
                                },
                              ),
                            ),

                            // Ayırıcı
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: Text(
                                ':',
                                style: TextStyle(
                                  fontSize: 34,
                                  fontWeight: FontWeight.w200,
                                  color: Colors.blue.shade300.withOpacity(0.5),
                                ),
                              ),
                            ),

                            // ── Dakika ─────────────────────────────────
                            Expanded(
                              child: _DrumColumn(
                                controller: _minCtrl,
                                itemCount: _minCount,
                                selectedValue: _minute,
                                itemExtent: _itemExtent,
                                onChanged: (rawIndex) {
                                  HapticFeedback.selectionClick();
                                  setState(() {
                                    _minute = rawIndex % _minCount;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                        // Üst fade
                        Positioned(
                          top: 0,
                          left: 0,
                          right: 0,
                          child: IgnorePointer(
                            child: Container(
                              height: 86,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    const Color(0xFF0A1628),
                                    const Color(0xFF0A1628).withOpacity(0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),

                        // Alt fade
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: IgnorePointer(
                            child: Container(
                              height: 86,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.topCenter,
                                  colors: [
                                    const Color(0xFF062549),
                                    const Color(0xFF062549).withOpacity(0),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ── Divider ─────────────────────────────────────────────
                Divider(
                  height: 1,
                  color: Colors.blue.shade300.withOpacity(0.15),
                ),

                // ── Butonlar ────────────────────────────────────────────
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
                  child: Row(
                    children: [
                      // İptal
                      Expanded(
                        child: TextButton(
                          onPressed: () => Navigator.of(context).pop(null),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                              side: BorderSide(
                                color: Colors.blue.shade300.withOpacity(0.3),
                              ),
                            ),
                          ),
                          child: Text(
                            'İptal',
                            style: TextStyle(
                              color: Colors.blue.shade200,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Ekle
                      Expanded(
                        flex: 2,
                        child: Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Colors.blue.shade400,
                                Colors.blue.shade700,
                              ],
                            ),
                            borderRadius: BorderRadius.circular(16),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.blue.shade500.withOpacity(0.30),
                                blurRadius: 14,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: () =>
                                Navigator.of(context).pop(_timeString),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Icon(Icons.add_rounded,
                                    color: Colors.white, size: 18),
                                SizedBox(width: 6),
                                Text(
                                  'Ekle',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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
// DRUM COLUMN  — sonsuz scroll, sağlıklı seçim
// ─────────────────────────────────────────────────────────────────────────────

class _DrumColumn extends StatelessWidget {
  final FixedExtentScrollController controller;
  final int itemCount;
  final int selectedValue;
  final double itemExtent;
  final ValueChanged<int> onChanged; // ham index döner, caller % alır

  const _DrumColumn({
    required this.controller,
    required this.itemCount,
    required this.selectedValue,
    required this.itemExtent,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListWheelScrollView.useDelegate(
      controller: controller,
      itemExtent: itemExtent,
      // Sonsuz scroll için çok büyük bir liste
      overAndUnderCenterOpacity: 1.0,
      diameterRatio: 1.8,
      squeeze: 1.25,
      physics: const FixedExtentScrollPhysics(),
      onSelectedItemChanged: onChanged,
      childDelegate: ListWheelChildBuilderDelegate(
        builder: (context, rawIndex) {
          final value = rawIndex % itemCount;
          final isSelected = value == selectedValue;

          return Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 160),
              style: TextStyle(
                fontSize: isSelected ? 32 : 20,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w300,
                color: isSelected
                    ? Colors.blue.shade100
                    : Colors.blue.shade200.withOpacity(0.42),
              ),
              child: Text(value.toString().padLeft(2, '0')),
            ),
          );
        },
      ),
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// REMINDER SETTINGS PAGE
// ─────────────────────────────────────────────────────────────────────────────

class ReminderSettingsPage extends StatefulWidget {
  const ReminderSettingsPage({super.key});

  @override
  State<ReminderSettingsPage> createState() => _ReminderSettingsPageState();
}

class _ReminderSettingsPageState extends State<ReminderSettingsPage> {
  bool _remindersEnabled = false;
  List<String> _reminderTimes = [];
  final NotificationService _notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _remindersEnabled = prefs.getBool('reminders_enabled') ?? false;
      _reminderTimes = prefs.getStringList('reminder_times') ?? [];
    });
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('reminders_enabled', _remindersEnabled);
    await prefs.setStringList('reminder_times', _reminderTimes);

    if (_remindersEnabled && _reminderTimes.isNotEmpty) {
      await _notificationService.scheduleDailyWaterReminders(_reminderTimes);
    } else {
      await _notificationService.cancelAllReminders();
    }
  }

  Future<void> _addReminderTime() async {
    final timeString = await _showDrumTimePicker(context);
    if (timeString != null && !_reminderTimes.contains(timeString)) {
      setState(() {
        _reminderTimes.add(timeString);
        _reminderTimes.sort();
      });
      await _saveSettings();
    }
  }

  Future<void> _deleteReminderTime(String time) async {
    setState(() {
      _reminderTimes.remove(time);
    });
    await _saveSettings();
  }

  Future<void> _sendTestNotification() async {
    await _notificationService.showTestNotification();
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Test bildirimi gönderildi! 💧'),
          backgroundColor: Colors.blue.shade700,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white70),
        title: Text(
          loc.enableReminders,
          style: TextStyle(
            color: Colors.white70,
            fontSize: width * 0.05,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xff062549)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              // ── Toggle ────────────────────────────────────────────────
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.withOpacity(0.2),
                      Colors.blue.withOpacity(0.1),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.blue.shade300.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: SwitchListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  title: Text(
                    loc.enableReminders,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  subtitle: Text(
                    loc.dailyReminderDescription,
                    style: const TextStyle(color: Colors.white70),
                  ),
                  value: _remindersEnabled,
                  activeColor: Colors.blue.shade300,
                  onChanged: (v) async {
                    setState(() => _remindersEnabled = v);
                    await _saveSettings();
                  },
                ),
              ),

              const SizedBox(height: 20),

              // ── Başlık + Ekle ──────────────────────────────────────────
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    loc.reminderTimes,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _remindersEnabled ? _addReminderTime : null,
                      borderRadius: BorderRadius.circular(30),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          gradient: _remindersEnabled
                              ? LinearGradient(colors: [
                                  Colors.blue.shade400,
                                  Colors.blue.shade600,
                                ])
                              : null,
                          color: _remindersEnabled
                              ? null
                              : Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Icon(Icons.add,
                            color: Colors.white, size: 28),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 15),

              // ── Liste / Boş Durum ──────────────────────────────────────
              if (_reminderTimes.isEmpty)
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.05),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white24, width: 1),
                  ),
                  child: Column(
                    children: [
                      Icon(
                        FontAwesomeIcons.clockRotateLeft,
                        size: 60,
                        color: Colors.blue.shade300.withOpacity(0.5),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        loc.noReminderAdded,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.7),
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        loc.addReminderHint,
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                          fontSize: 14,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else
                ...List.generate(_reminderTimes.length, (index) {
                  final time = _reminderTimes[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.blue.withOpacity(0.2),
                            Colors.blue.withOpacity(0.1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.blue.shade300.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        leading: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(colors: [
                              Colors.blue.shade400,
                              Colors.blue.shade600,
                            ]),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            FontAwesomeIcons.solidBell,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                        title: Text(
                          time,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        subtitle: Text(
                          loc.repeatsDaily,
                          style: const TextStyle(
                              color: Colors.white70, fontSize: 13),
                        ),
                        trailing: IconButton(
                          icon: Icon(FontAwesomeIcons.trashCan,
                              color: Colors.red.shade300, size: 20),
                          onPressed: () => _deleteReminderTime(time),
                        ),
                      ),
                    ),
                  );
                }),

              const SizedBox(height: 30),

              // ── Bilgilendirme ──────────────────────────────────────────
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.blue.shade900.withOpacity(0.3),
                      Colors.blue.shade700.withOpacity(0.2),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: Colors.blue.shade300.withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(FontAwesomeIcons.circleInfo,
                        color: Colors.blue.shade200, size: 24),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            loc.dailyReminderDescription,
                            style: TextStyle(
                              color: Colors.blue.shade100,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            loc.reminderInfoDescription,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
