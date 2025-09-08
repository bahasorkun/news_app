import 'package:flutter/material.dart';
import 'package:news_app/app.dart';
import 'package:news_app/core/app_state.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppState.instance.load();
  runApp(const MyApp());
}
