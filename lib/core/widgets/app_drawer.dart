import 'package:flutter/material.dart';
import 'package:news_app/core/l10n/app_localizations.dart';
import 'package:news_app/core/presentation/pages/about_page.dart';
import 'package:news_app/core/presentation/pages/settings_page.dart';
import 'package:news_app/core/presentation/pages/home_shell.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.indigo.shade200,
                    Colors.indigo.shade300,
                    Colors.indigo.shade400,
                    Colors.indigo.shade600,
                    Colors.indigo.shade800,
                    Colors.indigo.shade900,
                  ],
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.newspaper, color: Colors.black),
                  ),
                  SizedBox(width: 12),
                  Text(
                    "Misafir",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(AppLocalizations.of(context).t('home')),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => HomeShell()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(AppLocalizations.of(context).t('settings')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SettingsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text(AppLocalizations.of(context).t('about')),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AboutPage()),
                );
              },
            ),
            Divider(),
            SizedBox(height: 30),
            ListTile(
              leading: Icon(Icons.login),
              title: Text(AppLocalizations.of(context).t('login')),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
