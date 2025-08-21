import 'package:flutter/material.dart';
import 'package:news_app/core/widgets/app_appbar.dart';
import 'package:news_app/core/widgets/app_drawer.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppbar(title: "Hakkında"),
      drawer: AppDrawer(),
      body: Center(child: Text("hakkında")),
    );
  }
}
