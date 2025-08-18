import 'package:flutter/material.dart';
import 'package:news_app/features/splash/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      theme: ThemeData(
        colorScheme: ColorScheme.light(primary: Colors.indigo),
        useMaterial3: true,
      ),
      home: SplashScreen(),
    );
  }
}
