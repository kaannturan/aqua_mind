// ignore_for_file: deprecated_member_use

import 'package:aqua_mind/core/utils/provider_local.dart';
import 'package:aqua_mind/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LanguageSettingsPage extends StatelessWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final localeProvider = Provider.of<LocaleProvider>(context);
    final currentLocale = localeProvider.locale.languageCode;

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          loc.languageSelection,
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
              subtitle: 'English',
              flag: '🇺🇸',
              languageCode: 'en',
              isSelected: currentLocale == 'en',
              onTap: () {
                localeProvider.setLocale(const Locale('en'));
              },
            ),
            SizedBox(height: 12),
            _buildLanguageTile(
              context: context,
              title: 'Español',
              subtitle: 'Spanish',
              flag: '🇪🇸',
              languageCode: 'es',
              isSelected: currentLocale == 'es',
              onTap: () {
                localeProvider.setLocale(const Locale('es'));
              },
            ),
            SizedBox(height: 12),
            _buildLanguageTile(
              context: context,
              title: 'Français',
              subtitle: 'French',
              flag: '🇫🇷',
              languageCode: 'fr',
              isSelected: currentLocale == 'fr',
              onTap: () {
                localeProvider.setLocale(const Locale('fr'));
              },
            ),
            SizedBox(height: 12),
            _buildLanguageTile(
              context: context,
              title: 'Deutsch',
              subtitle: 'German',
              flag: '🇩🇪',
              languageCode: 'de',
              isSelected: currentLocale == 'de',
              onTap: () {
                localeProvider.setLocale(const Locale('de'));
              },
            ),
            SizedBox(height: 12),
            _buildLanguageTile(
              context: context,
              title: 'Italiano',
              subtitle: 'Italian',
              flag: '🇮🇹',
              languageCode: 'it',
              isSelected: currentLocale == 'it',
              onTap: () {
                localeProvider.setLocale(const Locale('it'));
              },
            ),
            SizedBox(height: 12),
            _buildLanguageTile(
              context: context,
              title: 'Português',
              subtitle: 'Portuguese',
              flag: '🇵🇹',
              languageCode: 'pt',
              isSelected: currentLocale == 'pt',
              onTap: () {
                localeProvider.setLocale(const Locale('pt'));
              },
            ),
            SizedBox(height: 12),
            _buildLanguageTile(
              context: context,
              title: '中文',
              subtitle: 'Chinese',
              flag: '🇨🇳',
              languageCode: 'zh',
              isSelected: currentLocale == 'zh',
              onTap: () {
                localeProvider.setLocale(const Locale('zh'));
              },
            ),
            SizedBox(height: 12),
            _buildLanguageTile(
              context: context,
              title: '日本語',
              subtitle: 'Japanese',
              flag: '🇯🇵',
              languageCode: 'ja',
              isSelected: currentLocale == 'ja',
              onTap: () {
                localeProvider.setLocale(const Locale('ja'));
              },
            ),
            SizedBox(height: 12),
            _buildLanguageTile(
              context: context,
              title: 'Русский',
              subtitle: 'Russian',
              flag: '🇷🇺',
              languageCode: 'ru',
              isSelected: currentLocale == 'ru',
              onTap: () {
                localeProvider.setLocale(const Locale('ru'));
              },
            ),
            SizedBox(height: 12),
            _buildLanguageTile(
              context: context,
              title: '한국어',
              subtitle: 'Korean',
              flag: '🇰🇷',
              languageCode: 'ko',
              isSelected: currentLocale == 'ko',
              onTap: () {
                localeProvider.setLocale(const Locale('ko'));
              },
            ),
            SizedBox(height: 12),
            _buildLanguageTile(
              context: context,
              title: 'العربية',
              subtitle: 'Arabic',
              flag: '🇸🇦',
              languageCode: 'ar',
              isSelected: currentLocale == 'ar',
              onTap: () {
                localeProvider.setLocale(const Locale('ar'));
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
        borderRadius: BorderRadius.circular(25),
        border: Border.all(
          color: isSelected ? Colors.blue : Colors.white24,
          width: 1,
        ),
      ),
      child: ListTile(
        leading: Text(
          flag,
          style: TextStyle(fontSize: 30),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 17,
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
            ? Icon(Icons.check_circle, color: Colors.blue, size: 24)
            : Icon(Icons.circle_outlined, color: Colors.white38, size: 24),
        onTap: onTap,
      ),
    );
  }
}
