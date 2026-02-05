// ignore_for_file: deprecated_member_use

import 'package:aqua_mind/core/utils/provider_local.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLocale = localeProvider.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          'Dil Seçimi',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.black, Color(0xff062549)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            _buildLanguageTile(
              context: context,
              title: 'Türkçe',
              subtitle: 'Turkish',
              flag: '🇹🇷',
              languageCode: 'tr',
              isSelected: currentLocale == 'tr',
              onTap: () {
                localeProvider.setLocale(const Locale('tr'));
              },
            ),
            SizedBox(height: 12),
            _buildLanguageTile(
              context: context,
              title: 'English',
              subtitle: 'İngilizce',
              flag: '🇺🇸',
              languageCode: 'en',
              isSelected: currentLocale == 'en',
              onTap: () {
                localeProvider.setLocale(const Locale('en'));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageTile({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String flag,
    required String languageCode,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isSelected
            ? Colors.blue.withOpacity(0.5)
            : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.white24,
          width: 2,
        ),
      ),
      child: ListTile(
        leading: Text(
          flag,
          style: TextStyle(fontSize: 32),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(
            color: Colors.white70,
            fontSize: 14,
          ),
        ),
        trailing: isSelected
            ? Icon(Icons.check_circle, color: Colors.blue, size: 28)
            : Icon(Icons.circle_outlined, color: Colors.white38, size: 28),
        onTap: onTap,
      ),
    );
  }
}
