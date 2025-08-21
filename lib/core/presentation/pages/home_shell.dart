import 'package:flutter/material.dart';
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
  final List<Widget> _pages = [
    FinancePage(),
    FootballPage(),
    NewsPage(),
    WeatherPage(),
    PharmacyPage(),
  ];

  final List<String> _titles = [
    "Finans",
    "Futbol",
    "Haberler",
    "Hava",
    "Eczane",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: _titles[_currentIndex]),
      drawer: AppDrawer(),
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        onTap: (value) => setState(() {
          _currentIndex = value;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance),
            label: "Finans",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_soccer),
            label: "Futbol",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Haberler"),
          BottomNavigationBarItem(
            icon: Icon(Icons.cloud_outlined),
            label: "Hava",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_pin),
            label: "Eczane",
          ),
        ],
      ),
    );
  }
}
