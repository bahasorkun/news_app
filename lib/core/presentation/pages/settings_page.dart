import 'package:flutter/material.dart';
import 'package:news_app/core/app_state.dart';
import 'package:news_app/core/l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context);
    return AnimatedBuilder(
      animation: AppState.instance,
      builder: (context, _) {
        final appState = AppState.instance;
        final isDark = appState.themeMode == ThemeMode.dark;
        final selectedLang =
            (appState.locale ?? Localizations.localeOf(context)).languageCode;

        return Scaffold(
          appBar: AppBar(title: Text(loc.t('settings'))),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: SwitchListTile(
                  value: isDark,
                  title: Text(loc.t('darkTheme')),
                  onChanged: (v) {
                    appState.setThemeMode(v ? ThemeMode.dark : ThemeMode.light);
                  },
                ),
              ),
              const SizedBox(height: 12),
              Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                      title: Text(
                        loc.t('language'),
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                    RadioListTile<String>(
                      value: 'tr',
                      groupValue: selectedLang,
                      title: Text(loc.t('turkish')),
                      onChanged: (_) => appState.setLocale(const Locale('tr')),
                    ),
                    RadioListTile<String>(
                      value: 'en',
                      groupValue: selectedLang,
                      title: Text(loc.t('english')),
                      onChanged: (_) => appState.setLocale(const Locale('en')),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
