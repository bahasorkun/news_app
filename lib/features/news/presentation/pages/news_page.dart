import 'package:flutter/material.dart';
import 'package:news_app/features/news/data/news_api.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text("News"));
  }
}
