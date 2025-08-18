import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(const Duration(seconds: 2), () {
    //   if (!mounted) return; // widget hâlâ ekranda mı kontrol et
    //   Navigator.pushReplacement(
    //     context,
    //     MaterialPageRoute(builder: (_) => const HomePage()),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/icons/news_logo.png",
              width: 150,
              semanticLabel: "News App Logosu",
            ),
            SizedBox(height: 20),
            Text(
              "News App",
              style: TextStyle(
                fontSize: 24,
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
