import 'package:flutter/material.dart';
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
  final int _currentIndex = 0;
  final List<Widget> _pages = [
    FinancePage(),
    FootballPage(),
    NewsPage(),
    WeatherPage(),
    PharmacyPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
