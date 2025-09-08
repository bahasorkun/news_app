import 'package:flutter/material.dart';
import 'package:news_app/core/l10n/app_localizations.dart';
import 'package:news_app/core/widgets/app_appbar.dart';
import 'package:news_app/core/widgets/app_drawer.dart';
import 'package:news_app/features/finance/presentation/pages/finance_page.dart';
import 'package:news_app/features/football/presentation/pages/football_page.dart';
import 'package:news_app/features/news/presentation/pages/news_page.dart';
import 'package:news_app/features/pharmacy/presentation/pages/pharmacy_page.dart';
import 'package:news_app/features/weather/presentation/pages/weather_page.dart';

class HomeShell extends StatefulWidget {
  const HomeShell({super.key});

  @override
  State<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends State<HomeShell> {
  int _currentIndex = 2;

  List<String> _titles(BuildContext context) => [
        AppLocalizations.of(context).t('finance'),
        AppLocalizations.of(context).t('football'),
        AppLocalizations.of(context).t('news'),
        AppLocalizations.of(context).t('weather'),
        AppLocalizations.of(context).t('pharmacy'),
      ];

  final Map<int, Widget> _pageCache = {};

  Widget _buildPage(int index) {
    if (_pageCache.containsKey(index)) return _pageCache[index]!;
    late final Widget page;
    switch (index) {
      case 0:
        page = const FinancePage();
        break;
      case 1:
        page = const FootballPage();
        break;
      case 2:
        page = const NewsPage();
        break;
      case 3:
        page = const WeatherPage();
        break;
      case 4:
        page = const PharmacyPage();
        break;
      default:
        page = const NewsPage();
    }
    _pageCache[index] = page;
    return page;
  }

  @override
  Widget build(BuildContext context) {
    final titles = _titles(context);
    return Scaffold(
      appBar: AppAppbar(title: titles[_currentIndex]),
      drawer: AppDrawer(),
      body: _buildPage(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) => setState(() {
          _currentIndex = value;
        }),
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_balance),
            label: AppLocalizations.of(context).t('finance'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.sports_soccer),
            label: AppLocalizations.of(context).t('football'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: AppLocalizations.of(context).t('news'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.cloud_outlined),
            label: AppLocalizations.of(context).t('weather'),
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.location_pin),
            label: AppLocalizations.of(context).t('pharmacy'),
          ),
        ],
      ),
    );
  }
}
